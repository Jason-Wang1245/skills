---
name: "simplify-code"
description: "the code generated was far too verbose and in-depth hence making it too complicated to understand"
disable-model-invocation: true
---

## Issue
The code that was just generated is far too complex and verbose with uncessary details

## What is desired
The user includes the clear and concise goal that they actually wanted

## Desired Re-Implementation
- Make the new code focus on only the clear and concise goal that the user wants to see
- Ensure the code is human-readable
- Write complex helper functions that seem overly complex into simpler functions
  - ex. previous function generates random ratings using bitwise operations into a function that simply generates a list of random numbers