#
# Cookbook Name:: devenv
# Recipe:: default
#
# Copyright 2013, Matt Caldwell
#
# All rights reserved - Do Not Redistribute
#
#

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
        make VIMRUNTIMEDIR=/usr/share/vim/vim73
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

git "/home/vagrant/.vim/bundle/vundle" do
    repository "git://github.com/gmarik/vundle.git"
    reference "master"
    user "vagrant"
    group "vagrant"
    action :sync
end

git "#{Chef::Config[:file_cache_path]}/devenv" do
    repository "git://github.com/mattcaldwell/dotfiles.git"
    remote "origin"
    reference "master"
    user "vagrant"
    group "vagrant"
    action :sync
end

bash "link_dotfiles" do
    user "vagrant"
    cwd "#{Chef::Config[:file_cache_path]}/devenv"
    code <<-EOH
        rake
    EOH
end

bash "install_vim_plugins" do
    user "vagrant"
    code <<-EOH
        vim +BundleInstall +qall
    EOH
end
