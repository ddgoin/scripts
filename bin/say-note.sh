MSG="$1"
notify-send "$MSG"
echo "$MSG" | espeak -s 150 2>/dev/null
