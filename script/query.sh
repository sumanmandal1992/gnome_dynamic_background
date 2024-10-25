#!/bin/bash
#
ls -p $1 | grep -v / | sed 's/\.[^.]*$//'
