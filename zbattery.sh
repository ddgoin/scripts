#!/bin/bash
HEART='♥'
EMPTY='♡'

if [[ "$UNODE" ]]; then
	if [[ `uname` == 'Linux' ]]; then
	  BATPATH=/sys/class/power_supply/BAT0
	  current_charge=$(cat $BATPATH/charge_now)
	  total_charge=$(cat $BATPATH/charge_full)
	fi
	#echo -n "$current_charge / "
	#echo -n "$total_charge"

	charged_slots=$(echo "(($current_charge/$total_charge)*10)+1" | bc -l | cut -d '.' -f 1)
	#echo -n "/ $charged_slots"
	if [[ $charged_slots -gt 10 ]]; then
	  charged_slots=10
	fi
	empty_slots=$(echo "10-$charged_slots" | bc )
	#echo -n "now it is $charged_slots"
	#echo -n "empty is $empty_slots"


	echo -n '#[fg=red] '
	for i in `seq 1 $charged_slots`; do echo -n " $HEART"; done

	if [[ $charged_slots -lt 10 ]]; then
	  echo -n '#[fg=white]'
	  for i in `seq 1 $(echo "10-$charged_slots" | bc)`; do echo -n " $EMPTY"; done
	fi
fi