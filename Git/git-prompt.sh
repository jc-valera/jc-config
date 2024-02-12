if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PROMPT_DIRTRIM=4							# Shorten deep paths in the prompt
	PS1='\[\033]0;Git | Bash v\v | \W\007\]' 	# set window title
	PS1="$PS1"'\n'                 				# new line
	
	# PS1="$PS1"'\[\033[1;35m\]'       			# change to bold purple
	# PS1="$PS1"'\u '             				# user@host<space>
	# PS1="$PS1"'\[\033[1;32m\]'       			# change to bold green
	# # PS1="$PS1"'▶ '
	# # PS1="$PS1"'➜ '
	# PS1="$PS1"'in '
	# PS1="$PS1"'\[\033[1;36m\]'       			# change to bold cyan
	# PS1="$PS1"'\w'                 				# current working directory
	
	PS1="$PS1"'\[\033[1;35m\]'       				# change to purple
	PS1="$PS1"'\u '             				# user@host<space>
	PS1="$PS1"'\n'                 				# new line
	PS1="$PS1"'\[\033[32m\]'       				# change to bold green
	PS1="$PS1"'➜ '
	PS1="$PS1"'\[\033[1;36m\]'       			# change to cyan
	PS1="$PS1"'\w'                 				# current working directory
	
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\[\033[1;33m\]'  		# change color to bold yellow
			PS1="$PS1"'`__git_ps1`'   			# bash function
		fi
	fi
	PS1="$PS1"'\[\033[0m\]'        				# change color
	PS1="$PS1"'\n'                 				# new line
	# PS1="$PS1"'$ '                 				# prompt: always $
	PS1="$PS1"'❯ '                 			# prompt: always ❯
	# PS1="$PS1"' 🚀 '               			# prompt: always 🚀
fi

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc

# Evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"
then
	for c in "$HOME"/bash_completion.d/*.bash
	do
		# Handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
		. "$c"
	done
fi

# Git status options
# Shows * or + for unstaged and staged changes, respectively.
export GIT_PS1_SHOWSTASHSTATE=true

# shows $ if there are any stashes.
export GIT_PS1_SHOWDIRTYSTATE=true

# Shows % if there are any untracked files.
export GIT_PS1_SHOWUNTRACKEDFILES=true

# shows <, >, <>, or = when your branch is behind, ahead, diverged from,
# or in sync with the upstream branch, respectively.
export GIT_PS1_SHOWUPSTREAM="auto"
