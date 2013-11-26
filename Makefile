mac: installbrew linkup installvim

linux: linkup aptget

vagrant:

linkup:
	./scripts/bin/relink

installbrew:
	while read line; do \
		brew install "$$line"; \
	done < ./scripts/setup/mac/brew.list

installvim:
	rm -rf ~/.vim/bundle
	mkdir -p ~/.vim/bundle
	cd ~/.vim/bundle; git clone https://github.com/Valloric/YouCompleteMe.git; cd YouCompleteMe; git submodule update --init --recursive; ./install.sh --clang-completer

aptget:

