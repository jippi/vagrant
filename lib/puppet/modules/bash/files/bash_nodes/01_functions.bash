function savealias() {
  echo "!!! This command is aliased for safety reasons." >&2
  echo "!!! If you are serious use `type -P $1`." >&2
  return 1
}

function ask() {
  echo -n "Enter 'y' to proceed: "
  read answer
  [ "$answer" = 'y' ] && return 0
  return 1
}

# Syntax-highlight JSON strings or files
function sjson() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript
	else # pipe
		python -mjson.tool | pygmentize -l javascript
	fi
}

# Syntax-highlight XML strings or files
function sxml() {
	if [ -t 0 ]; then # argument
		echo "$*" | pygmentize -l xml
	else # pipe
		pygmentize -l xml
	fi
}

# Syntax-highlight HTML strings or files
function shtml() {
	if [ -t 0 ]; then # argument
		echo "$*" | pygmentize -l html
	else # pipe
		pygmentize -l html
	fi
}
