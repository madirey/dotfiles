mac: installbrews installdb relink sshkeys vimdeps getdevrepos pythondeps rubydeps jsdeps

linux: relink aptget

vagrant:

relink:
	./scripts/bin/relink
	. ~/.bash_profile

sshkeys:
	@echo Installing SSH keys...
	mkdir -p ~/.ssh
	cp ~/Dropbox/keys/* ~/.ssh
	chmod 700 ~/.ssh/*

installbrews:
	@echo Installing homebrew packages...
	while read line; do \
		brew install "$$line"; \
	done < ./scripts/setup/mac/brew.list
	cd /usr/local/library && git stash && git clean -d -f
	brew update

installdb:
	initdb /usr/local/var/postgres -E utf8
	mkdir -p ~/Library/LaunchAgents
	cp /usr/local/Cellar/postgresql/9.3.1/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
	launchctl load -w /Users/mattcaldwell/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
	pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

getdevrepos:
	@while read line; do \
		IFS=/ read -r account repo <<< "$$line"; \
		cd ~/Development; mkdir -p "$$account"; cd "$$account"; git clone git@github.com:$$line; \
	done < ./scripts/setup/repos.list

vimdeps:
	@echo Installing vim dependencies...
	rm -rf ~/.vim/bundle
	mkdir -p ~/.vim/bundle
	cd ~/.vim/bundle; git clone https://github.com/Valloric/YouCompleteMe.git; cd YouCompleteMe; git submodule update --init --recursive; ./install.sh --clang-completer

pythondeps:
	@echo Installing global Python dependencies...
	sudo easy_install pip
	sudo pip install -r ./scripts/setup/requirements.txt

rubydeps:
	@echo Installing ruby dependencies...
	@if [ ! -f "$$HOME/.rvm/bin/rvm" ]; then \
		\curl -L https://get.rvm.io | bash -s stable; \
	fi
	@rvm use --default --install 1.9.3
	@echo "Installing ruby gems..."
	@while read line; do \
		IFS=" " read -r gem version <<< "$$line"; \
		echo Installing $$gem ...; \
		/bin/bash -l -c ". ~/.rvm/scripts/rvm; rvm use 1.9.3; gem install $$gem --version $${version//[()]/}"; \
	done < ./scripts/setup/gems.list

jsdeps:
	@echo Installing js dependencies...
	@cd ~/Development/joyent/node; ./configure --prefix=~/local; make install
	@cd ~/Development/isaacs/npm; make install
	@while read line; do \
		npm install -g "$$line"; \
	done < ./scripts/setup/npm.list

aptget:

