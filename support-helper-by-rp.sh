#!/bin/bash


pid=$(xdotool getwindowfocus getwindowpid)
proc_name=$(cat /proc/$pid/comm)

if [ ! -d ${HOME}/support-text-expander/text-expander ]; then
    mkdir ${HOME}/support-text-expander/text-expander
fi

base_dir=$(realpath "${HOME}/support-text-expander/text-expander")

shopt -s globstar

abbrvs=$(find "${base_dir}" -type f | sort | sed "s?^${base_dir}/??g" )

name=$(zenity --list --title=Support-Helper-By-RP --width=275 --height=400 --column=Abbreviations $abbrvs)

path="${base_dir}/${name}"

if [ -f "${base_dir}/${name}" ]
then
  if [ -e "$path" ]
  then
   
    clipboard=$(xsel -b -o)
   
    echo -n "$(cat "$path")" | xsel -p -i
    echo -n "$(cat "$path")" | xsel -b -i
    sleep 0.3
    xdotool key shift+Insert

    sleep 0.5
    echo $clipboard | xsel -b -i

  else
    zenity --error --text="Abbreviation not found:\n${name}"
  fi
fi
