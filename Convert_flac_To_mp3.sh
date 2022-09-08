for i in *.flac; do lame -b 320 -h "${i}" "${i%.flac}.mp3"; done
mp3gain -ge *.mp3
mkdir flac
mv *.flac flac 
