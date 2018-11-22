#!/bin/bash
# Command for running neovim

if [[ "$1" = /* ]]; then
  file_name="$(basename ${1})"
  dir_name="$(dirname ${1})"
else
  file_name="$1"
  dir_name="$(pwd)"
fi

echo $dir_name
echo $file_name

# Run the docker command
docker run -i -t -P -v /home:/home thornycrackers/neovim /bin/sh -c "cd $dir_name;nvim $file_name"
