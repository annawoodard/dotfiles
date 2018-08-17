#!/usr/bin/env sh

mkdir -p ~/.local/bin

dir=$(mktemp -d)
cd "$dir"

### ripgreg
wget https://github.com/BurntSushi/ripgrep/releases/download/0.7.1/ripgrep-0.7.1-i686-unknown-linux-musl.tar.gz
tar xaf ripgrep*
cp ripgrep-0.7.1-i686-unknown-linux-musl/rg ~/.local/bin

### neovim
git clone git@github.com:neovim/neovim.git
cd neovim
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local" CMAKE_BUILD_TYPE=RelWithDebInfo
make install
cd -

### dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/bundles

rm -rf "$dir"

for package in flake8 neovim jedi yapf python-language-server autopep8
do
  pip install --user $package
done

# FIXME font ligatures?

