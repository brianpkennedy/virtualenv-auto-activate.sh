#!/bin/bash
# virtualenv-auto-activate.sh
# 
# Installation:
#   Add this line to your .bashrc or .bash-profile:
#
#       source /path/to/virtualenv-auto-activate.sh
#
#   Go to your project folder, run "virtualenv .venv", so your project folder
#   has a .venv folder at the top level, next to your version control directory.
#   For example:
#   .
#   ├── .git
#   │   ├── HEAD
#   │   ├── config
#   │   ├── description
#   │   ├── hooks
#   │   ├── info
#   │   ├── objects
#   │   └── refs
#   └── .venv
#       ├── bin
#       ├── include
#       └── lib
#
#   The virtualenv will be activated automatically when you enter the directory.
_virtualenv_auto_activate() {
    CURRENT_DIR="$(pwd -P)"
    SOURCED=0

    while [ "$CURRENT_DIR" != "/" ] && [ $SOURCED -eq 0 ]; do
        if [ -e "$CURRENT_DIR/.venv" ]; then
            # Check to see if already activated to avoid redundant activating
            VENV_PATH="$CURRENT_DIR/.venv"

            # Make sure if .venv is a symlink itself, we look up VIRTUAL_ENV appropriately
            READLINK="$(readlink $VENV_PATH)"
            READLINK=${READLINK%/}

            if [ "$VIRTUAL_ENV" != "$CURRENT_DIR" ] && [ "$VIRTUAL_ENV" != "$READLINK" ]; then
                _VENV_NAME=$(basename $CURRENT_DIR)
                echo Activating virtualenv \"$_VENV_NAME\"...
                VIRTUAL_ENV_DISABLE_PROMPT=1
                source .venv/bin/activate
                _OLD_VIRTUAL_PS1="$PS1"
                PS1="($_VENV_NAME)$PS1"
                export PS1
            fi
            # Mark as sourced
            SOURCED=1
        else
            CURRENT_DIR="$(dirname $CURRENT_DIR)"
        fi
    done
}

export PROMPT_COMMAND="_virtualenv_auto_activate; $PROMPT_COMMAND"
