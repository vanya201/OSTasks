#!/bin/bash
file_count=$(find /etc -type f ! -type l | wc -l)
echo "Number of files in /etc: $file_count"
