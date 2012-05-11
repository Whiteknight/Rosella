---
layout: rosella
title: Rosella Core
---

## Overview

The Rosella Net library contains a number of classes and routines for basic
networking tasks.

## Concepts

## Namespaces

### Rosella.Net

### Rosella.Net.Http

### Rosella.Net.Uri

## Classes

### Rosella.Net.MimeBase64

### Rosella.Net.Protocol

### Rosella.Net.Protocol.File

### Rosella.Net.Protocol.Http

### Rosella.Net.SocketFactory

### Rosella.Net.Uri

### Rosella.Net.Uri.File

### Rosella.Net.Uri.Http

### Rosella.Net.UserAgent

### Rosella.Net.UserAgent.SimpleHttp

## Examples

### Winxed

Here's an example for performing an HTTP GET request and, if successful,
printing out the returned HTML content:

    var ua = new Rosella.Net.UserAgent.SimpleHttp();
    var response = ua.get("http://www.parrot.org");
    if (response.status_code() == 200) {
        say(response.get_content());
    }

### NQP-rx

## Users

* All Rosella libraries use the Core library functionality
