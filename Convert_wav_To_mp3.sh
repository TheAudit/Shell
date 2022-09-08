for i in *.wav; do lame -b 320 -h "${i}" "${i%.wav}.mp3"; done
mp3gain -ge *.mp3
mkdir wav
mv *.wav wav 
