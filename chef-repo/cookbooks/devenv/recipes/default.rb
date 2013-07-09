#
# Cookbook Name:: devenv
# Recipe:: default
#
# Copyright 2013, Matt Caldwell
#
# All rights reserved - Do Not Redistribute
#
#

git "#{Chef::Config[:file_cache_path]}/devenv" do
    repository "git://github.com/mattcaldwell/dotfiles.git"
    reference "master"
    action :sync
end
