function autoCompleteHostname() {   
	local hosts;
	local cur;
	hosts=($(awk '{print $1}' ~/.ssh/known_hosts | cut -d, -f1));
	cur=${COMP_WORDS[COMP_CWORD]};
	COMPREPLY=($(compgen -W '${hosts[@]}' -- $cur ))
} 
complete -F autoCompleteHostname ssh;
