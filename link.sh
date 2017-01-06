#!/usr/bin/zsh

BASEDIR=$(dirname $(readlink -f $0))
dot_files=(.zshrc .zshrc.zni)
rewrite=false

usage() {
  print "Usage: link.sh [OPTIONS]
Creates symlinks for all dot files.

    -r, 		delete symlinks and create new
    -h, 		print this help message
  "
  exit 0
}

link() {
  file=$1
  ln -s $BASEDIR/$file ~/$file
}

while getopts ':hr' arg; do
  case $arg in
    r) rewrite=true;;
    h) usage;;
    \?) print "unknown option -$OPTARG"; usage;;
  esac
done

for file in $dot_files; do
  if [ -f $BASEDIR/$file ]; then
    if [ ! -L ~/$file ]; then
      link $file
    else
      if [ "$rewrite" = true ]; then
	print "removing symlink $file and creating a new one"
        rm ~/$file
   	link $file
      else
        print "symlink for $file already exists, if you want to rewrite all symlinks user -r"
      fi
    fi
  else
    echo "file $file does not exists"
  fi 
done

