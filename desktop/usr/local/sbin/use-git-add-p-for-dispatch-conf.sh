#!/bin/bash

# The configuration section starts from the word "configuration:"

########################################################################
# Description:
#   A helper to utilize "git add -p" for dispatch-conf "merge".
# Arguments:
#   1: Filename which will constitute the new configuration candidate
#      after your edit
#   2: the config file used so far. E.g. /etc/foo
#   3: supplied by the new emerge.  E.g. /etc/._cfg0000_foo
#

# configuration:

# Log file. When an error happens, you can read this.
LOG=/tmp/dispatch-conf-git-add-p.log

# You can set the initial .git/ by setting GIT_TEMPLATE_DIR envvar;
# The entire contents will be copied into the .git/ directory. Read
# "git help init" for more.

{
    # By putting the entire body in a brace, edits of this file
    # during its run won't affect the process. See
    # http://stackoverflow.com/questions/3398258/edit-shell-script-while-its-running
    # http://stackoverflow.com/questions/2285403/how-to-make-shell-scripts-robust-to-source-being-changed-as-they-run/2358432#2358432

    # Save stdout and stderr
    exec 3>&1
    exec 4>&2

    # Redirect all to tho log file.
    exec 1>$LOG 2>&1

    function die(){
        # Usually this won't be called, but when it is called, dispatch-conf will crash, too.
	exec 1>&3 3>&-
	exec 2>&4 4>&-
	echo "Error occured. Read $LOG.
Hit enter to continue."
	read

	exit 1
    }

    DIR=`mktemp -d` || die
    chmod 700 $DIR
    cd $DIR
    git init . || die

    NAME=`basename "$2"`
    cp "$2" "$NAME"
    git add "$NAME" || die

    git commit -a -m "The current config." || die

    cp "$3" "$NAME"

    # Recover stdout & error for "git add -p".
    exec 1>&3 3>&-
    exec 2>&4 4>&-

    git add -p . || die

    exec 3>&1 4>&2
    exec 1>>$LOG 2>&1

    git commit -m "The merge candidate." || die
    # Discard the old file, so that the chosen hunks become the new config file candidate.
    git reset --hard || die

    cp "$NAME" "$1"

    # clean up
    cd /tmp
    rm -r "$DIR"

    # Don't delete this exit. Read the first comment after the opening brace.
    exit 0
}

########################################################################
# Author: Teika kazura
# License: Donated to the Public Domain

### ChangeLog:
#   2012-07-26: The initial release.
