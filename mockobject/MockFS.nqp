# Copyright (C) 2010, Austin Hastings. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

# Provides a Mock FileSystem to avoid IO during testing.
class Cuculus::MockFS;

INIT {
    our %_Osname_class_map := Hash.new(
        :DEFAULT(Cuculus::MockFS::Unix),
        :linux(Cuculus::MockFS::Unix),
    );
}

our method get_osname_map() {
    our %_Osname_class_map;
}

our method _init_obj(*@pos, *%named) {
    my %map := self.get_osname_map();
    my $osname := %*VM<osname>;

    $osname := 'DEFAULT' unless %map.contains: $osname;

    my $class := %map{$osname};
    my $obj := $class.new( |@pos, |%named ); # NB: Returns a different type than Path.
    $obj;
}

class Cuculus::MockFS::Unix is Cuculus::MockFS;

has @!cwd_path;
has $!user_id;
has %!user_groups;
has %!volumes; # Not used much, but makes paths easier.

INIT {
	my @multisubs := <
		add_entry
		chdir
		exists
		get_contents
		has_type
		mkpath
	>;

	for @multisubs -> $name {
		Parrot::define_multisub($name, :method, :starting_with($name));

		my $string_sub := Parrot::get_hll_global( "Cuculus::MockFS::Unix::{$name}__String" );
		unless Parrot::is_null($string_sub) {
			Parrot::define_multisub($name, [ $string_sub ], signatures => [ <_ string> ] );
		}
	}
	#~ Parrot::define_multisub('mkpath', :method, :starting_with('mkpath'));
	#~ Parrot::define_multisub('mkpath',
		#~ :method, [ Cuculus::MockFS::Unix::mkpath__String ],
		#~ signatures => [ < _ string >,	], # Note: lowercase 'string'
	#~ );
}

my method add_entry__String( $path, *%named ) {
    self.add_entry( Path.new($path), |%named );
}

my method add_entry__Path( $path, *%named ) {
    pir::die("Cannot add entry $path - that path already exists" )
        if pir::defined( self.find_path( $path ) );

    my %path_attrs := %named.clone;
    %path_attrs.delete: <name>;
    %path_attrs.delete: <type>;
    %path_attrs.delete: <contents>;
    self.mkpath( $path, |%path_attrs );

    my $entry := self.find_path( $path );

    unless pir::defined( $entry ) {
        _dumper(self);
        _dumper($path);
        pir::die( "Failed to add entry $path" );
    }

    # Specify some default properties:
    my %defaults := Hash.new:
        contents => '',
        type => 'file',
        ;

    # Merge in specified attrs
    $entry[-1].merge( %defaults, %named, :priority('right'));
}

our method chdir__ANY($path) {
    pir::die( "Don't know how to chdir to a(n) " ~ pir::typeof__SP($path) ~ ". Use a String or Path.");
}

our method chdir__Path($path) {
    my @new_wd := self.find_path: $path;

    pir::die("Can't cd to $path - does not exist in this fs")
        unless pir::defined(@new_wd);

    self.cwd_path: @new_wd;
}

our method chdir__String($str) {
    self.chdir: Path.new($str);
}

our method cwd() {
    my @path := self.cwd_path.map: -> $part { $part<name>; };
    my $*FileSystem := self;
    Path.new: |@path, :absolute;
}

my method cwd_path($value?)  {
    pir::defined($value) ?? (@!cwd_path := $value) !! @!cwd_path.clone;
}

our method directory_separator() { '/' }

our method exists__Path($path) {
    my $item := self.find_path: $path;
    pir::defined($item);
}

our method exists__String($path) {
    self.exists: Path.new($path);
}

our method exists__ANY($path) {
    pir::die( "Don't know how to check if " ~ pir::typeof__SP($path) ~ " exists. Use a String or Path");
}

my method find_path($path) {
    my @path := $path.is_absolute
        ?? [ %!volumes{ $path.volume } ]
        !! self.cwd_path;

    my $cur := @path[-1];
    my @elements := $path.elements;

    for @elements -> $next {
        return my $undef
            unless $cur<type>  eq 'directory' && $cur<contents>.contains: $next;

        @path.push: $cur := $cur<contents>{$next};
    }

    @path;
}

my method get_contents__ANY($path) {
    pir::die( "Don't know how to get contents of " ~ pir::typeof__SP($path) ~ ". Use a String or Path");
}

my method get_contents__Path($path) {
    my @path := self.find_path($path);
    my $item := @path[-1];
    my $type := $item<type>;

    if $type eq 'device' {
        pir::die("Cannot get contents of device: $path");
    }
    elsif $type eq 'directory' {
        $item<contents>.keys;
    }
    elsif $type eq 'file' {
        $item<contents>;
    }
    else {
        # Should I follow? Need a use case, but probably.
        pir::die("Cannot get contents of link: $path");
    }
}

my method get_contents__String($path) {
    self.get_contents: Path.new($path);
}

my method has_type__ANY($path, $type) {
    pir::die( "Don't know how to check if a(n) " ~ pir::typeof__SP($path) ~ " is a $type. Use a String or Path");
}

my method has_type__Path($path, $type) {
    my  @path := self.find_path($path);
    @path[-1]<type> eq $type;
}

my method has_type__String($path, $type) {
    self.has_type: Path.new($path), $type;
}

our method is_device($path) { self.has_type($path, 'device'); }
our method is_directory($path) { self.has_type($path, 'directory'); }
our method is_file($path) { self.has_type($path, 'file'); }
our method is_link($path) { self.has_type($path, 'link'); }

my method _init_obj(*@pos, *%named) {
    %!volumes<> := self.new_entry( :name("/"), :type(<directory>) );
    self.cwd_path: [ %!volumes<> ];

    self._init_args(|@pos, |%named);
}

my method mkpath__ANY($path) {
    pir::die( "Don't know how to mkpath a(n) " ~ pir::typeof__SP($path) ~ ". Use a String or Path");
}

my method mkpath__Path($path, *%named) {
    my @path := $path.is_absolute
        ?? [ %!volumes{ $path.volume } ]
        !! self.cwd_path;

    my $cur := @path[-1];
    my @elements := $path.elements;

    for @elements -> $next {
        if $cur<type> eq 'directory' {
            unless $cur<contents>.contains: $next {
                $cur<contents>{$next} := self.new_entry( :name($next), :type(<directory>));
            }

            @path.push: $cur := $cur<contents>{$next};
        }
        else {
            pir::die("Cannot mkpath $path - element {$cur<name>} is not a directory");
        }
    }

    @path;
}

my method mkpath__String($path) {
    self.mkpath: Path.new($path);
}

my method new_entry(:$type = 'file', *%details) {
    my $contents;
    my $undef;

    if $type eq 'directory' {
        $contents := Hash.new;
    }

    %details.merge: Hash.new(
        :contents( $contents ),
        :group( $undef ),
        :mode( $undef ),
        :type( $type ),
        :user( $undef ),
    );

    %details;
}

our method open($path, *%named) {
    my $fh   := pir::new__PS('FileHandle');
    my $mode := '' ~ %named<mode> // 'r';

    $fh.open(~ $path, $mode);

    # Not a loop because of prefix ops (+, ~)
    $fh.buffer_size( +%named<buffer_size> )
            if %named.contains( <buffer_size> );
    $fh.buffer_type( ~%named<buffer_type> )
            if %named.contains( <buffer_type> );
    $fh.encoding( ~%named<encoding> )
            if %named.contains( <encoding> );

    $fh;
}

our method slurp($path, *%named) {
    %named<mode> := 'r';
    my $fh := self.open($path, |%named);
    my $slurp := $fh.readall;
    $fh.close;
    $slurp;
}
