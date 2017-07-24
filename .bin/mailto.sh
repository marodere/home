#!/bin/bash

url="$1"
if pidof thunderbird; then
	thunderbird -remote "mailto(${url##mailto:})"
else
	thunderbird -compose "${url}"
fi
