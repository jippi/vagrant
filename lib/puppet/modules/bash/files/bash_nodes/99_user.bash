if [ -f $HOME/.bash_nodes ];
then
	. $HOME/.bash_nodes
fi

# Load users own settings
if [ -f $HOME/.bash_local ];
then
	. $HOME/.bash_local
fi
