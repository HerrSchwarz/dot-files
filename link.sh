#!/usr/bin/zsh

dot_files=(.zshrc .zshrc.zni)

for file in $dot_files; do
  if [ ! -L ~/$file ]; then
    if [ -f ./$file ]; then
      ln -s ./$file ~/$file
    else
      echo "file $file does not exists"
    fi
  else
    echo "symlink for $file already exists"
  fi 
done
