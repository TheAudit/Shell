i=0
s=65    # decimal ASCII "A" 
for f in *.mp3
do
    # convert to octal then ASCII character for selection tag
    files[i]=$(echo -en "\0$(( $s / 64 * 100 + $s % 64 / 8 * 10 + $s % 8 ))")
    files[i+1]="$f"    # save file name
    ((i+=2))
    ((s++))
done

result=$(whiptail --backtitle "Select a file" --title "MP3 Files" \
    --menu "Please select a file " 14 40 6 "${files[@]}" 3>&2 2>&1 1>&3-)


#if [[ $? == 255 ]]
if ! [[ $result =~ $re ]] ; 
then
    echo "You cancelled"
    exit 0
fi

index1=$(echo $result | tr '[ABCDEFGHI]' '[1-9]' | tr 'JKLMNOPQR' '1-9' | tr 'STUVWXYX' '1-8')
index2=$(echo $result | tr '[ABCDEFGHI]' '0' | tr 'JKLMNOPQR' '9' | tr 'STUVWXYXZ' '18')
index=$(($index1 + $index2))
a=1
for f in *.mp3
do
    if [ $a -eq $index ]
    then
        eyeD3 "$f"
    fi
((a+=1))
done
