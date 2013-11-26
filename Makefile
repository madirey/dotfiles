mac: installbrews relink sshkeys vimdeps pythondeps

linux: relink aptget

vagrant:

relink:
	./scripts/bin/relink
	. ~/.bash_profile

sshkeys:
	mkdir -p ~/.ssh
	cp ~/Dropbox/keys/* ~/.ssh
	chmod 700 ~/.ssh/*

installbrews:
	while read line; do \
		brew install "$$line"; \
	done < ./scripts/setup/mac/brew.list

vimdeps:
	rm -rf ~/.vim/bundle
	mkdir -p ~/.vim/bundle
	cd ~/.vim/bundle; git clone https://github.com/Valloric/YouCompleteMe.git; cd YouCompleteMe; git submodule update --init --recursive; ./install.sh --clang-completer

pythondeps:
	sudo easy_install pip
	sudo pip install -r ./scripts/setup/requirements.txt

aptget:

