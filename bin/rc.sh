#!/bin/zsh

# Create a temporary file with a random string
random_str=$(LC_CTYPE=C tr -dc A-Za-z0-9 </dev/urandom | head -c 8)
tmpfile="/tmp/tmpfile_$random_str.sh"

# Open the temporary file in VIM
vim $tmpfile

# Check if the file is empty
if [[ ! -s $tmpfile ]]; then
  echo "The file is empty. Nothing will be executed. 😕"
else
  # Source the content of the temporary file and execute it
  source $tmpfile
  echo "The file has been executed successfully! 🎉"
fi

# Remove the temporary file
rm $tmpfile
