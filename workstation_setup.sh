#!/bin/bash

# Text colouring
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

function create_repos {
	# Create directory for repos
	echo 'Creating ~/repos... Directory'
	mkdir -p ~/repos
}

function install_homebrew {
	# Install Homebrew
	echo 'Installing Homebrew...'

	if [ ! $(which brew) ]; then
		# from https://brew.sh
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
}

function install_homebrew_packages {
	# Install Homebrew packages
	echo 'Installing Homebrew packages...'

	if [ ! -f "Brewfile" ]; then
		echo -e "${RED}Error${NC}: Brewfile doesn't exist. Make sure you're running from the repo folder" >&2
		exit 1
	fi

	cp Brewfile "${HOME}"/

	pushd "${HOME}"/ || return

		/usr/local/bin/brew bundle install
		rm Brewfile

	popd || return
}

function install_kubernetes_deps {

	echo "Installing Kubernetes dependencies.  Please note Kubernetes' kubectl is installed with Docker for Mac."
	# Install what we need to manage Terraform and Kubernetes
	install_terraform

	# Install Terragrunt
	echo "Installing Terragrunt"
	/usr/local/bin/brew install terragrunt

	echo "Installing gruntwork installer"
	curl -LsS https://raw.githubusercontent.com/gruntwork-io/gruntwork-installer/master/bootstrap-gruntwork-installer.sh | bash /dev/stdin --version v0.0.23

	# Install Kubergrunt which we leverage as part of our Terraform config
	echo "Installing kubergrunt"
	gruntwork-install --binary-name "kubergrunt" --repo "https://github.com/gruntwork-io/kubergrunt" --tag "v0.5.2"
}

function install_terraform {
	git clone git@github.com:Homebrew/homebrew-core.git ~/repos/homebrew-core

	pushd ~/repos/homebrew-core || return

		echo "Installing Terraform 0.12.29"

		# we have to checkout a specific commit
		git -C "$(brew --repo homebrew/core)" fetch --unshallow
		git checkout f64341455ec4f2d9577d20a1937431a6ce7b3eb9

		# Knock out the 
		pushd Formula || return
			if [ ! "$(which terraform)" ]; then
				brew unpin terraform; brew unlink terraform;
			fi
			brew install terraform.rb
			brew link terraform
			brew switch terraform 0.12.29
		popd || return
	popd || return
}

# function copy_ssh_config {
# 	# Copy SSH config to home folder
# 	echo 'Copying SSH config...'

# 	if [ -f ~/.ssh/config ]; then
# 		echo -e "${YELLOW}Warning${NC}: ~/.ssh/config already exists, not touching" >&2
# 	fi

# 	cp -n .ssh/config ~/.ssh/config
# }

function setup_pyenv {
	# Setup pyenv
	echo 'Setting up pyenv...'

	if [ ! "$(which pyenv)" ]; then
		echo -e "${RED}Error${NC}: pyenv isn't installed, check brew and rerun"
		exit 1
	fi

	/usr/local/bin/pyenv install --skip-existing 2.7.15
	/usr/local/bin/pyenv global 2.7.15
}

function setup_ruby {
	echo "Setup rbenv"
	echo "eval \"$(rbenv init -)\"" >> "$HOME"/.bashrc

	echo "Activating rbenv..."
	# shellcheck source=/dev/null
	source "${HOME}/.bashrc"

	echo "Installing Ruby 2.6.2.  This can take a while..."
	rbenv install 2.6.2
}

function install_pip_packages {
	# Install pip packages
	echo 'Installing pip packages...'

	# Install pip packages
	if [ ! "$(which pip)" ]; then
		echo -e "${RED}Error{$NC}: pip isn't installed, checl brew and rerun"
		exit 1
	fi

	$(/usr/local/bin/pyenv root)/versions/2.7.15/bin/pip install --upgrade pip
	$(/usr/local/bin/pyenv root)/versions/2.7.15/bin/pip install \
		molecule \
		awscli \
		boto \
		boto3 \
		mysql-python \
		pymysql
}

function setup_goenv {
	# Setup goenv
	echo 'Setting up goenv...'

	if [ ! "$(which goenv)" ]; then
		echo -e "${RED}Error${NC}: goenv ins't installed, check brew and rerun"
		exit 1
	fi

	/usr/local/bin/goenv install --skip-existing 1.11.4
	/usr/local/bin/goenv global 1.11.4
}

echo "Beginning Janky Install Script 0.0.1"

# Install procedure
create_repos
install_homebrew
install_homebrew_packages
install_kubernetes_deps

# copy_ssh_config
setup_pyenv
install_pip_packages
setup_goenv

# Done
echo 'Done'
