all: build

build:
	winxed setup.winxed build

test: build
	winxed setup.winxed test

install: build
	winxed setup.winxed install

clean:
	winxed setup.winxed clean
