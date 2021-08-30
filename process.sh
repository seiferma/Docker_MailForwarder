#!/bin/bash

# Configuration parameters
PROBE_INTERVAL=60
MAX_INTERVAL=$((15*60))

# Internal configuration
MAX_INTERVAL_MS=$((MAX_INTERVAL*1000))
LAST_EXEC_FILE=~/.last_execution
IMAPNOTIFY_CFG_FILE=~/.imapnotify.conf
MODE=$1

# Handling of sigterms
exit_script() {
	trap - SIGINT SIGTERM # clear trap
	kill -- -$$ # Sends SIGTERM to child/sub processes
	exit 0
}
trap exit_script SIGINT SIGTERM

start_forked_notifier() {
	echo 0 > $LAST_EXEC_FILE
	goimapnotify -conf $IMAPNOTIFY_CFG_FILE &
}

process_mails() {
	date +"%s" > $LAST_EXEC_FILE
	fdm -v fetch
}

run_watchdog() {
	while true; do
		LAST_EXECUTION=$(cat $LAST_EXEC_FILE)
		CURRENT_TIME=$(date +"%s")
		if [ $((CURRENT_TIME-LAST_EXECUTION)) -gt $MAX_INTERVAL_MS ]; then
			echo "Forcing mail processing because last processing happened more than $MAX_INTERVAL seconds ago."
			process_mails
		fi
		sleep $PROBE_INTERVAL
	done
}


if [ "$MODE" == "start" ]; then
	start_forked_notifier
	run_watchdog
elif [ "$MODE" == "process" ]; then
	process_mails
else
	echo "The requested mode \"$MODE\" is unknown. Doing nothing."
fi

