#!/bin/bash
echo -e "\n\nUser custom provisioning..."
echo "current user: $(whoami)"

echo -e "\n\nInstalling Homebrew..."
curl "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" -o /home/ndsadmin/brew_install.sh
chmod a+xr /home/ndsadmin/brew_install.sh
echo | /home/ndsadmin/brew_install.sh
rm -f /home/ndsadmin/brew_install.sh
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/home/ndsadmin/.bash_profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo -e "\n\nInstalling gcc (required for gh)..."
brew install gcc

echo -e "\n\nInstalling Github CLI..."
brew install gh

echo -e "\n\nInstalling ASDF..."
brew install asdf
echo ". /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh" >>/home/ndsadmin/.bash_profile
echo "legacy_version_file = yes" >/home/ndsadmin/.asdfrc
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf plugin add python https://github.com/tuvistavie/asdf-python.git

echo -e "\n\nInstalling GHE Login Tool into ~/.bash_profile..."
{
  echo 'alias ghe-login="/home/ndsadmin/user-github-auth.sh"'
  echo 'alias ll="ls -la"'
} >>/home/ndsadmin/.bash_profile

echo -e "\n\nCompleted custom user provisioning.\n\n"
