#!/bin/bash

function yesno() {
  answer=$(whiptail --yesno "$1" 0 0 3>&1 1>&2 2>&3; echo $?)
  if [ $answer -eq 0 ]; then
    eyeD3 --remove-all *.mp3 > /dev/null
  fi
}

yesno "Do you want to reset all tags on these files?"

Title=$(whiptail --title "Album Input Box" --inputbox "What is the album title?" 10 60 - 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    {
    for ((i = 0 ; i <= 100 ; i+=20)); do
        if [ $i = 0 ]; then
            eyeD3 -A "$Title" *.mp3 > /dev/null
        else
            sleep 0.2
        fi
        echo $i
    done
    } | whiptail --gauge "Please wait while updating Album Title on all tracks." 6 60 0
    
else
    echo "You chose Cancel."
fi

Artist=$(whiptail --title "Artist Input Box" --inputbox "What is the album artist?" 10 60 - 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    {
    for ((i = 0 ; i <= 100 ; i+=20)); do
        if [ $i = 0 ]; then
            eyeD3 -a "$Artist" *.mp3 > /dev/null
        else
            sleep 0.2
        fi
        echo $i
    done
    } | whiptail --gauge "Please wait while updating Artist on all tracks." 6 60 0
else
    echo "You chose Cancel."
fi

tn=1

for file in *.mp3; 
do echo $file;

    

    Track=$(whiptail --title "Track Input Box" --inputbox "What is the Track Title?" 10 60 "$file" 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        eyeD3 -t "$Track" "$file" > /dev/null
    else
        echo "You chose Cancel."
    fi

    TrackN=$(whiptail --title "Track Input Box" --inputbox "What is the Track Number?" 10 60 $tn 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        eyeD3 -n "$TrackN" "$file" > /dev/null
        tn=$((TrackN+1))
    else
        echo "You chose Cancel."
    fi

    

done

FILE=COVER.jpg
if [ -f "$FILE" ]; then
    {
        for ((i = 0 ; i <= 100 ; i+=20)); do
            if [ $i = 0 ]; then
                eyeD3 --add-image "COVER.jpg:FRONT_COVER" *.mp3
            fi
            sleep 0.2
            echo $i
        done
    } | whiptail --gauge "Please wait while updating cover art." 6 60 0
else
    whiptail --msgbox "No cover art to update, if you want to add cover art you will need to an appropriate image file named COVER.jpg in this directory" 10 50
fi

whiptail --msgbox "Completed tagging" 10 50


kill -9 $PPID
