#export PATH=/usr/local/opt:/usr/local/bin:$(pyenv root)/shims:/usr/local/opt/perl/bin/:$PATH
export PATH="/${HOME}/repos/scripts:$PATH"
export PATH="$GOENV_ROOT/bin:$PATH"
#export PATH=$PATH:$(go env GOPATH)/bin:~/.cargo/bin
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#eval "$(goenv init -)"
#export GOENV_ROOT="$HOME/.goenv"
#export GOPATH="$HOME/go"
#export PATH=$PATH:"/usr/local/bin/go/golint"
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
#export PATH=${PATH}:${HOME}/.nodenv/versions/$(node --version | sed 's/v//g')/bin/
export PATH="${HOME}/repos/helper-scripts:${PATH}"
export PATH=/usr/local/opt:/usr/local/bin:$PATH
export PATH="/opt/homebrew/opt/mongodb-community@5.0/bin:$PATH"
export DYLD_LIBRARY_PATH=/opt/homebrew/opt/zlib/lib:$DYLD_LIBRARY_PATH

autoload -Uz compinit
compinit

export PATH="/usr/local/opt/v8@3.15/bin:$PATH"
export PATH="/usr/local/opt/v8@3.15/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.3p62/bin:$PATH"
eval "$(rbenv init - zsh)"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
source /Users/rishitha.mandava/.rvm/scripts/rvm

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
