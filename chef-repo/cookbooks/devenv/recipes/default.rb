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

# include_recipe "git"
include_recipe "python"
include_recipe "ruby"

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

git "#{Chef::Config[:file_cache_path]}/devenv" do
    repository "git://github.com/mattcaldwell/dotfiles.git"
    remote "origin"
    reference "master"
    action :sync
end

bash "link_dotfiles" do
    cwd "#{Chef::Config[:file_cache_path]}/devenv"
    code <<-EOH
        rake
    EOH
end
