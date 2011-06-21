---
layout: rosella
title: Rosella Event
---

## Overview

The Rosella Event library uses a
[subscribe/publish](http://en.wikipedia.org/wiki/Publish/subscribe) event
mechanism to promote decoupling in complex software systems.

## Concepts

### Decoupling

Decoupling is a way for components in a large or complex system to communicate
with each other without needing to explicitly pass references, require
specific interfaces, or hard-code type references in the software. Any part
of the code can raise an event without needing to be aware of which portions
of the software are going to be notified about it. Likewise, objects can
subscribe to an event by name without needing to know all the places that
event can be raised.

This helps maintainability. Consider the example of a text editor which
receives notifications from the operating system when a file has been modified
by a separate program. Obviously the editor widget would need to know about
these changes to update the buffer. The text editor would have a
"FileSystemListener" object which read events from the operating system and
then called an "Update" method on the TextBuffer object when changes occured.
Consider next that we would like to add a system of plugins to our text editor
which may also be interested in these events. The naive approach would be to
modify FileSystemListener to call "Update" on the TextBuffer and the new
plugin, but this strategy has obvious drawbacks: If we add in a second plugin
as well, we would have to make yet another modification to FileSystemListener.

By using the Rosella Event library, the FileSystemListener can publish a
"TextFileUpdated" event, which can be subscribed to by many other utilities,
widgets, and plugins. New plugins can subscribe themselves to the event
without needing to modify any existing code in the application.

## Namespaces

None.

## Classes

### Event

`Rosella.Event` is the underlying event object. It serves as little more than
data storage, and is not useful by itself. Events are stored by name in a
`Rosella.Event.Manager` object, and are raised through that interface.

When the Event is raised, status information and parameter values are updated
in the Event, and it is passed to all available subscribers. The Manager
object is in charge of passing the Event object to available Queue objects,
and the Queues use the Event to invoke all available subscribers.

Event subscribers are Action objects (from `Rosella.Action` library) which
take the Event as the first and only parameter. The Event object contains the
named and positional arguments that were passed to `Manager.raise_event`
method. The Action can read these parameters out of the Event.

Event also contains some additional functionality. The method `Event.handled`
can be used to mark the Event as being handled. Once the Event is marked as
handled, the raise sequence ends and no additional subscribers are invoked.

### Event.Manager

`Rosella.Event.Manager` is used as a centralized mechanism for storing
and managing Events and subscribers in Queues. The Manager provides an
interface for working with events in a general way.

Events in the Manager are organized by unique string name. Events can be
added or removed by name, or new Actions can be subscribed to Events by name.
The EventManager will automatically create a new Event if one does not already
exist with the given name. No individual subscriber or publisher needs to be
aware of the order in which subscriptions occur. A publisher does not need to
be aware of whether the Event even exists yet or not. An Event not existing is
treated exactly the same as an Event with zero subscribers.

Subscribers are arranged into named Queues. Queues organize subscribers by the
Event they subscribe to, and by subscriber name. Queues can selectively
invoke subscribers depending on properties of the Event. The Manager provides
a default queue, which can be addressed by passing `null` as the queue name.
The default queue cannot be deleted or modified, but it can be disabled by
calling `.toggle_queue(null, 0)`.

When raising an Event, if the method `.raise_event()` is used all Queues
receive the Event. If `.raise_event_queue()` is used, only a particular named
Queue receives the Event.

### Event.Queue

`Rosella.Event.Queue` is used to organize subscribers, selectively invoke them
when an Event is raised, and perform other behaviors as required. Queues break
subscribers into two groups: event-specific subscribers which only trigger in
response to specific named Events, and general subscribers which trigger in
response to all Events passed to the Queue.

The default Queue class pushes Events directly to subcribers. Custom
subclasses of Queue could store Events until polled by subscribers, or provide
other behaviors.

The default Queue implementation does not do any delaying, persisting,
passing Events to distributed program nodes, etc. These are all features that
you would expect to find in a more heavy-duty pub/sub implementation.
Custom subclasses of Queue may be used to provide those kinds of behaviors,
however.

## Examples

### Winxed

### NQP-rx

    my $manager := Rosella::construct(Rosella::Event::Manager);
    $manager.register_event("Test");
    $manager.add_subscriber_action("Foo", Rosella::construct(Rosella::Action::Sub,
        sub($ev) { pir::say("Action Invoked!"); }
    ));
    $manager.raise_event("Test");

## Users
