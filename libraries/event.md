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

`Rosella.Event` is the underlying event object. In general you do not want
to invoke this class directly, because the interface is not designed for nice
direct use. You should use `Rosella.Event.EventManager` instead to manage a
named list of Event objects through a nice interface.

When the Event is raised, all subscribers to that event are notified. In the
common case, methods on subscriber objects are called with the Event object
as the first and only parameter. Additional payload data and other data are
stored in the Event object itself.

### Event.EventManager

`Rosella.Event.EventManager` is used as a centralized mechanism for storing
and managing a list of Event objects. The EventManager provides a nice
interface for working with events in a general way.

Events in the EventManager are organized by unique string name. Events can be
added or removed by name, or new Actions can be subscribed to Events by name.
The EventManager will automatically create a new Event if one does not already
exist with the given name. No individual subscriber or publisher needs to be
aware of the order in which subscriptions occur. A publisher does not need to
be aware of whether the Event even exists yet or not. An Event not existing is
treated exactly the same as an Event with zero subscribers.

## Examples

### Winxed

### NQP-rx

## Users
