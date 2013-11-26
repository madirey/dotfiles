dotfiles
========

Prerequisites
=============
<del>1. VirtualBox  - https://www.virtualbox.org/wiki/Downloads</del>
<del>2. Vagrant - http://downloads.vagrantup.com/</del>
1. Set environment variables to point to ((defaults shown) I use Dropbox for this...):
    - DOTFILES_SSH=~/Dropbox/dotfiles/ssh
    - DOTFILES_APPS=~/Dropbox/dotfiles/apps
    - DOTFILES_KEYCHAIN=~/Dropbox/dotfiles/keychain
    - DOTFILES_OPENVPN=~/Dropbox/dotfiles/openvpn_keys
    - DOTFILES_INSTALLPATH=~/Development/mattcaldwell

Installation
============
1. Clone this repository to DOTFILES_INSTALLPATH

    cd $DOTFILES_INSTALLPATH; git clone git@github.com:mattcaldwell/dotfiles.git

<del>2. Launch vagrant VM

    cd dotfiles; vagrant up
</del>

    3. Run 'make mac'

    4. Install applications in $DOTFILES_APPS

    5. Import keychain from $DOTFILES_KEYCHAIN

    6. Install openvpn keys from $DOTFILES_OPENVPN (if needed for vpn client)

Using
=====
<del>
1. vagrant ssh
2. and you're done!
</del>
