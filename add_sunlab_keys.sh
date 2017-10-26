#!/bin/bash

if (( $# < 1 )); then
    echo "Usage: ./add_sunlab_keys <hosts file>"
	  echo "The hosts file should a contain one host per line."
	  exit
fi

while IFS= read line; do ssh-keyscan -H "$line" >> ~/.ssh/known_hosts; done < "$1"
