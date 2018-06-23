#!/usr/bin/env sh

xbps-install rustup gcc # needed for linking
rustup install stable

mkdir -p ~/.vim/autoload
curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > ~/.vim/autoload/plug.vim

# Plug 'rust-lang/rust.vim'
