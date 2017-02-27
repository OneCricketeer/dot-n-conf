alias vst='vagrant status'
alias vup='vagrant up'
alias vdo='vagrant halt'
alias vssh='vagrant ssh'
alias vkill='vagrant destroy'

alias upgrade_pip2_packages="pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip2 install -U"
alias upgrade_pip3_packages="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip3 install -U"
