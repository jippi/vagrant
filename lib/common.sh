CURRENT_FOLDER=$(pwd)

PLATFORM='unknown'

unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   PLATFORM='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   PLATFORM='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   PLATFORM='darwin'
fi

function speak_to_user() {
	case $PLATFORM in
		'darwin' )
			say $@ > /dev/null 2>&1 &
			;;

		'linux' )
			espeak -z "$@" > /dev/null 2>&1 &
			;;

		*)
			echo "Unsupported platform: $PLATFORM (speak_to_user)"
			exit 1
	esac
}

# 'development' is default environment
if [ -z "$ENV" ];
then
	ENV="development"
fi

# Check the environment exist
if [ ! -d "$CURRENT_FOLDER/$ENV" ]
then
	echo "Sorry, invalid environment";
	exit 1;
fi

function cd_env() {
	# Change to the environment folder
	cd "$CURRENT_FOLDER/$ENV/$1"
}
