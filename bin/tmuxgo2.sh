#!/bin/bash
PROJECTS=$HOME/Projects
WORK=$PROJECTS/Work

TAB1_TITLE="NWYC Backend"
TAB1_SESSION="nwyc"
TAB1_WINDOWS=( $WORK/NWYC-Backend )

TAB2_TITLE="Hillday Backend"
TAB2_SESSION="hillday"
TAB2_WINDOWS=( $WORK/Hillday-Backend )

TAB3_TITLE="Constituent Voice 2"
TAB3_SESSION="cv2"
TAB3_WINDOWS=( $WORK/ConstituentVoice2-Deprecated )

TAB4_TITLE="Notes"
TAB4_SESSION="notes"
TAB4_WINDOWS=( $PROJECTS/Notes )

if [ $# -eq 0 ]; then
	com_args=" --geometry=243x68+30"
	for t in `seq 1 4`; do
		com_args=$com_args" --tab -e 'bash -ic \"$0 $t\"'"
	done
	eval gnome-terminal $com_args
else
	# set the tab title in the terminal
	TITLEATTR="TAB"$1"_TITLE"
	TITLE=("${!TITLEATTR}")
	echo -en "\033]0;$TITLE\a"

	SESSIONATTR="TAB"$1"_SESSION"
	SESSION=("${!SESSIONATTR}")
	tmux has-session -t $SESSION
	if [ $? -eq 0 ]; then
		echo "Session $SESSION already exists. Attaching."
		tmux attach -t $SESSION
		exit 0;
	fi
	tmux new-session -d -s $SESSION
	W_COUNTER=0
	WINDOWATTR="TAB$1""_WINDOWS""[@]"
	for WINDOW in "${!WINDOWATTR}"; do
		let W_COUNTER=$W_COUNTER+1
		tmux new-window -t $SESSION:$W_COUNTER -k -c ${WINDOW[0]}
	done
	tmux select-window -t $SESSION:1
	tmux attach -t $SESSION
fi
