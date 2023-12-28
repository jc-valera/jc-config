# Some good standards, which are not used if the user
# creates his/her own .bashrc/.bash_profile

# --show-control-chars: help showing Korean or accented characters
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias ls='ls -F --color=auto --show-control-chars'
# alias ll='ls -l'
alias ll='ls -lash'
alias ll.='ls -la'
alias lls='ls -la --sort=size'
alias llt='ls -la --sort=time'

alias work='cd /d/Users/jcvalera/Documents/Projects/'
alias countFiles='ls -1 | wc -l'

case "$TERM" in
xterm*)
	# The following programs are known to require a Win32 Console
	# for interactive usage, therefore let's launch them through winpty
	# when run inside `mintty`.
	for name in node ipython php php5 psql python2.7 winget
	do
		case "$(type -p "$name".exe 2>/dev/null)" in
		''|/usr/bin/*) continue;;
		esac
		alias $name="winpty $name.exe"
	done
	;;
esac
