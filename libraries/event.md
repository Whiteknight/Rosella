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

### Rosella.Event

## Classes

### Event

`Rosella.Event` is the primary eventing mechanism in the Event library. Events
are self-contained objects which take subscribers and control flow of control
during a publish sequence. Events can be used by themselves or they can be
managed by a `Rosella.Event.Manager` object.

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

### Event.Dispatcher

`Rosella.Event.Dispatcher` objects are used to dispatch event subscribers when
the event is published. The subscriber determines when and how to be notified,
including the ability to schedule notification on a separate thread or task.

`Rosella.Event.Dispatcher` is an abstract parent type. Use a subclass instead,
through `Rosella.Event.Dispatcher.Factory`

### Event.Dispatcher.Factory

`Rosella.Event.Dispatcher.Factory` is a factory type for obtaining reference to
a suitable dispatcher object. Dispatchers are typically reusable, so the Factory
may return an existing reference.

By default, there are three types of dispatchers that can be obtained:
"immediate", "task" and "thread". These three types correspond to the dispatcher
types described below.

### Event.Dispatcher.Immediate

`Rosella.Event.Dispatcher.Immediate` dispatches the event immediately in the
current task. Event publishing is paused while the subscriber is notified. Only
short subscription routines should be used with the Immediate class, since it
delays the current task and the current event publish operation.

### Event.Dispatcher.Task

`Rosella.Event.Dispatcher.Task` dispatches the event on a separate Task in the
current Parrot thread. This is only available if Parrot is built with green
threads support.

### Event.Dispatcher.Thread

`Rosella.Event.Dispatcher.Thread` dispatches the task to a new thread. This is
only available if Parrot is built with threads support.

### Event.Manager

`Rosella.Event.Manager` is an organizational mechanism for storing and accessing
events. Events in the manager are organized by name, and can be accessed by
name. To subscribe to an event or to modify the event, look it up in the manager
first and then access the Event instance directly.

The manager has the nice feature of lazily creating events when accessed, so it
doesn't matter who accesses the event in what order. If a publisher publishes an
event before there are any subscribers, the publish silently does nothing. If
subscribers attempt to subscribe to the event before it has been created
elsewhere, the event will automatically be created.

Event Manager objects do not need to be used, but they add a nice layer of
abstraction and decoupling logic between separate parts of a system relying on
events.

### Event.Payload

When an Event is published and new instance of `Rosella.Event.Payload` is sent
to each subscriber. The Payload is unique to that subscriber and can be read
and modified without having to worry about data corruption. When the Event is
published, a hash of all generated payloads is returned for possible examination
by the publisher.

### Event.Subscriber

A `Rosella.Event.Subscriber` object is a pair of a callback and a dispatcher.
It is used to manage subscriptions and control how the subscriber is notified
when the event is published.

### Event.Subscriber.Factory

The `Rosella.Event.Subscriber.Factory` type is a factory for creating
subscribers. It automatically assigns a Dispatcher object as necessary.

## Examples

### Winxed

### NQP-rx

    my $manager := Rosella::construct(Rosella::Event::Manager);
    my $event := $manager.get_event("Test");
    $event.subscribe("Foo",
        sub($payload) { pir::say("Action Invoked!"); }
    ));
    my %payloads := $event.publish();

## Users
