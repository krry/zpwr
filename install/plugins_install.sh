if ! test -f common.sh; then
    echo "Must be in $ZPWR/install directory" >&2
    exit 1
fi

source common.sh

if [[ "$ZPWR_OS_TYPE" == "darwin" ]]; then
    distroName=Mac
elif [[ "$ZPWR_OS_TYPE" == "linux" ]]; then
    distroName=$(perl -lne 'do{($_=$1)=~s@"@@g;print;exit0}if m{^ID=(.*)}' /etc/os-release)
else
    if [[ "$ZPWR_OS_TYPE" == freebsd ]]; then
        distroName=FreeBSD
    fi
fi

prettyPrintBox "Installing Pathogen"
mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/bundle" && curl -LSso "$HOME/.vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim

goInstallerDir
source vim_plugins_install.sh

prettyPrintBox "Installing UltiSnips snippets"
goInstallerDir
ln -sfn $ZPWR_INSTALL/UltiSnips $HOME/.vim/UltiSnips

nvimDir="$HOME/.config/nvim"
[[ ! -d "$nvimDir" ]] && mkdir -p "$nvimDir"

prettyPrintBox "Installing neovim config"
goInstallerDir
ln -sf $ZPWR_INSTALL/init.vim "$nvimDir"

#custom settings for tmux powerline
tmuxPowerlineDir="$HOME/.config/powerline/themes/tmux"
tmuxPowerlineColorsDir="$HOME/.config/powerline/colorschemes/tmux"
[[ ! -d "$tmuxPowerlineDir" ]] && mkdir -p "$tmuxPowerlineDir"
[[ ! -d "$tmuxPowerlineColorsDir" ]] && mkdir -p "$tmuxPowerlineColorsDir"

prettyPrintBox "Installing Tmux Powerline Config"
goInstallerDir
ln -sf $ZPWR_INSTALL/.config/powerline/themes/default.json "$tmuxPowerlineDir/default.json"
echo ln -sf $ZPWR_INSTALL/.config/powerline/themes/default.json "$tmuxPowerlineDir/default.json"
ln -sf $ZPWR_INSTALL/.config/powerline/colorschemes/default.json "$tmuxPowerlineColorsDir/default.json"
echo ln -sf $ZPWR_INSTALL/.config/powerline/colorschemes/default.json "$tmuxPowerlineColorsDir/default.json"

prettyPrintBox "Installing Tmux Plugin Manager"
[[ ! -d "$HOME/.tmux/plugins/tpm"  ]] && mkdir -p "$HOME/.tmux/plugins/tpm"

git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

if [[ ! -f "$HOME/.ctags" ]]; then
    prettyPrintBox "Linking .ctags to home directory"
    goInstallerDir
    echo ln -sf $ZPWR_INSTALL/.ctags "$HOME/.ctags"
    ln -sf $ZPWR_INSTALL/.ctags "$HOME/.ctags"
fi

symFiles=(.tmux.conf .ideavimrc .vimrc grc.zsh conf.gls conf.df conf.ifconfig conf.mount conf.whois .iftopcolors .inputrc)

for file in ${symFiles[@]} ; do
    prettyPrintBox "Installing $file to $HOME"
    goInstallerDir
    echo ln -sf $ZPWR_INSTALL/$file "$HOME/$file"
    ln -sf $ZPWR_INSTALL/$file "$HOME/$file"
done

prettyPrintBox "Installing Tmux plugins"
goInstallerDir
source "tmux_plugins_install.sh"

[[ ! -f "$ZPWR_HIDDEN_DIR/.tokens.sh" ]] && touch "$ZPWR_HIDDEN_DIR/.tokens.sh"

prettyPrintBox "HushLogin to $HOME"
[[ ! -f "$HOME/.hushlogin" ]] && touch "$HOME/.hushlogin"

prettyPrintBox "Installing my.cnf to $HOME"
[[ ! -f "$HOME/.my.cnf" ]] && touch "$HOME/.my.cnf"

#prettyPrintBox "Changing pager to cat for MySQL Clients such as MyCLI"
#echo "[client]" >> "$HOME/.my.cnf"
#echo "pager=cat" >> "$HOME/.my.cnf"

prettyPrintBox "Installing htoprc file...."
goInstallerDir

htopDIR="$HOME/.config/htop"
if [[ ! -f "$htopDIR/htoprc" ]]; then
    if [[ ! -d "$htopDIR" ]]; then
        mkdir -p "$htopDIR"
    fi
    cp htoprc "$htopDIR"
fi
