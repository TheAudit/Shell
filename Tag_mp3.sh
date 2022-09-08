#!/bin/bash
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

for file in *.mp3; 
do echo $file;
t=1
Track=$(whiptail --title "Track Input Box" --inputbox "What is the Track Title?" 10 60 "$file" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    eyeD3 -t "$Track" "$file" > /dev/null
else
    echo "You chose Cancel."
fi

TrackN=$(whiptail --title "Track Input Box" --inputbox "What is the Track Number?" 10 60 $t 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    eyeD3 -n "$TrackN" "$file" > /dev/null
else
    echo "You chose Cancel."
fi

t=$t + 1

done


#!/bin/bash
{
    for ((i = 0 ; i <= 100 ; i+=20)); do
        if [ $i = 0 ]; then
            eyeD3 --add-image "COVER.jpg:FRONT_COVER" *.mp3
        fi
        sleep 0.2
        echo $i
    done
} | whiptail --gauge "Please wait while updating cover art." 6 60 0
