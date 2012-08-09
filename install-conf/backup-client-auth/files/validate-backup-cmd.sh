#! /bin/bash

# Check that the command is an rsync command, that the parameters are
# correct and that there are no unusual special characters which may
# be used for shell redirection or job control.  If the above criteria
# are met then execute it using sudo.

case "$SSH_ORIGINAL_COMMAND" in
	*\&*|*\|*|*\;*|*\>*|*\<*|*\!*)
		exit 1
	;;
	/usr/bin/rsync\ --server\ --sender*)
		sudo $SSH_ORIGINAL_COMMAND
	;;
	rdiff-backup\ --server*)
		sudo /usr/bin/rdiff-backup --server --restrict-read-only /
	;;
	*)
		exit 1
	;;
esac