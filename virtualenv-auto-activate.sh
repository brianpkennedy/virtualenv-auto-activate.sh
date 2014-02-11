#   The virtualenv will be activated automatically when you enter the directory.
_virtualenv_auto_activate() {
    if [ -e ".venv" ]; then
        # Check to see if already activated to avoid redundant activating
        DIR="$(pwd -P)/.venv"
	# Make sure if .venv is a symlink itself, we look up VIRTUAL_ENV appropriately
        READLINK="$(readlink $DIR)"
		READLINK=${READLINK%/} 


        if [ "$VIRTUAL_ENV" != "$DIR" ] && [ "$VIRTUAL_ENV" != "$READLINK" ]; then
            _VENV_NAME=$(basename `pwd`)
            echo Activating virtualenv \"$_VENV_NAME\"...
            VIRTUAL_ENV_DISABLE_PROMPT=1
            source .venv/bin/activate
            _OLD_VIRTUAL_PS1="$PS1"
            PS1="($_VENV_NAME)$PS1"
            export PS1
        fi
    fi
}

export PROMPT_COMMAND="_virtualenv_auto_activate; $PROMPT_COMMAND"
