#le Bewley <dale @ guifreelife org> - Sat Feb 19 08:53:30 PST 2011
#-------------------------------------------------------------------------------
# Use me to get your tmux session restored after a reboot or reattach daily.
# Just type tmuxgo every morning and hit ^bd at the end of the day. Login
# remotely and do the same.
#
# Attaches to an existing session named $SESSION or will create one if missing.
# The created session will be pre-populated with a number of windows.
#
# For example, window 0 running IRC, window 1 running email, window 2 logged
# into a router used daily.
#
#
# Bugs & Todos:
#   o If session already exists, instantiate any missing windows.
#     This could be done by checking tmux list-windows, not sure needed.
#
#   o Window 0 automatically changes name to 'weechat 0.3.3', ignoring
#     the -n option. The following should fix it, but does not:
#       tmux set-window-option -t $SESSION:0 automatic-rename off
#     Same thing happens when issuing configure command on Arista switches.
#     Note that name (#W) and title (#T) are not necessarily the same value.
################################################################################

# the name of your primary tmux session
if [ -z "$1" ]; then
	SESSION=$USER
else
	SESSION="$1"
fi

#echo -en "\033]0;$SESSION\a"
echo -en "\033]0;${PWD##*/}\a"

# if the session is already running, just attach to it.
tmux has-session -t $SESSION
if [ $? -eq 0 ]; then
	echo "Session $SESSION already exists. Attaching."
	tmux attach -t $SESSION
	exit 0;
fi

# create a new session, named $SESSION, and detach from it
tmux new-session -d -s $SESSION

# Now populate the session with the windows you use every day
# Some windows I specifically want at a particular index.
# I always want IRC in window 0 and Email in window 1.

tmux new-window    -t $SESSION:1 -n local

# After those base windows are statically defined, what follows depends where
# I'm working and what my focus is.
# So these new windows will just  number sequentially.

# all done. select starting window and get to work
# you may need to cycle through windows and type in passwords
# if you don't use ssh keys
tmux select-window -t $SESSION:1
tmux attach -t $SESSION
