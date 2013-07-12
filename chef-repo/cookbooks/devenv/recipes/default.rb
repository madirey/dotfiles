#
# Cookbook Name:: devenv
# Recipe:: default
#
# Copyright 2013, Matt Caldwell
#
# All rights reserved - Do Not Redistribute
#
#

bash "update" do
    code <<-EOH
        apt-get update -y
        DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
    EOH
end

package "git" do
    action :install
end

package "mercurial" do
    action :install
end

package "python" do
    action :install
end

package "ruby-rvm" do
    action :install
end

package "openssl" do
    action :install
end

package "libssl-dev" do
    action :install
end

package "libreadline-dev" do
    action :install
end

package "checkinstall" do
    action :install
end

# for vim
package "libperl-dev" do
    action :install
end

package "python-dev" do
    action :install
end

package "ruby-dev" do
    action :install
end

package "python-pip" do
    action :install
end

package "build-essential" do # for YouCompleteMe
    action :install
end

package "cmake" do # for YouCompleteMe
    action :install
end

bash "install_virtualenv" do
    code <<-EOH
        pip install virtualenv
        pip install virtualenvwrapper
    EOH
end

# FIXME: determine version dynamically
bash "install_vim" do
    code <<-EOH
        apt-get remove vim vim-runtime gvim vim-tiny vim-common vim-gui-common
        cd ~
        hg clone https://vim.googlecode.com/hg/ vim
        cd vim
        ./configure --with-features=huge \
                    --enable-rubyinterp \
                    --enable-pythoninterp \
                    --enable-perlinterp \
                    --enable-luainterp \
                    --enable-cscope \
                    --prefix=/usr
        make VIMRUNTIMEDIR=/usr/share/vim/vim74a
        checkinstall -D -y
        update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
        update-alternatives --set editor /usr/bin/vim
        update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
        update-alternatives --set vi /usr/bin/vim
    EOH
end

bash "install_ruby_rvm" do
    code <<-EOH
        \curl -L https://get.rvm.io |
          bash -s stable --ruby --autolibs=enable --auto-dotfiles
        rvm install 1.9.2
        rvm gemset create devenv
        rvm use 1.9.2@devenv --default
        gem install rake
    EOH
end

bash "git_config" do
    code <<-EOH
        git config --global user.name "Matt Caldwell"
        git config --global user.email "matt.caldwell@gmail.com"
    EOH
end

directory "/home/vagrant/.vim/bundle" do
    owner "vagrant"
    group "vagrant"
    recursive true
end

directory "/home/vagrant/Development/mattcaldwell" do
    owner "vagrant"
    group "vagrant"
    recursive true
end

git "/home/vagrant/Development/mattcaldwell/dotfiles" do
    repository "git://github.com/mattcaldwell/dotfiles.git"
    remote "origin"
    reference "master"
    user "vagrant"
    group "vagrant"
    action :sync
end

link "/home/vagrant/.bashrc" do
    owner "vagrant"
    group "vagrant"
    to "/home/vagrant/Development/mattcaldwell/dotfiles/src/bashrc"
end

link "/home/vagrant/.vimrc" do
    owner "vagrant"
    group "vagrant"
    to "/home/vagrant/Development/mattcaldwell/dotfiles/src/vimrc"
end

link "/home/vagrant/.scripts" do
    owner "vagrant"
    group "vagrant"
    to "/home/vagrant/Development/mattcaldwell/dotfiles/scripts"
end

git "/home/vagrant/.vim/bundle/YouCompleteMe" do
    repository "git://github.com/Valloric/YouCompleteMe.git"
    remote "origin"
    reference "master"
    user "vagrant"
    group "vagrant"
    enable_submodules true
    action :sync
end

# TODO: add '--clang-completer'
bash "install_youcomplete_me" do
    cwd "/home/vagrant"
    code <<-EOH
        cd /home/vagrant/.vim/bundle/YouCompleteMe
        ./install.sh
    EOH
end
