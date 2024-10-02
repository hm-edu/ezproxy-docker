#!/bin/bash
echo -e "[$(date)] Generating missing files (if any) . . ."
/usr/local/ezproxy/ezproxy -d /usr/local/ezproxy/config -m > /dev/null
/usr/local/ezproxy/ezproxy -d /usr/local/ezproxy/config