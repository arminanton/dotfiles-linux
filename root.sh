#!/usr/bin/env bash

items=(
  .dotfiles
  .ssh
  .config
  .cache
  .gnupg
  .rvm
  .nvm
  .npm
  .rustup
  .copilot
  .dotnet
  .sonar
  .cargo
  .gradle
  .java
  .yarn
  .repoconfig
  .vscode-remote-containers
  .vscode-server
)

echo "# Custom Bindings - Shared Settings" | sudo tee -a /etc/fstab >/dev/null
for item in "${items[@]}"; do
  src="/home/ndsadmin/${item}"
  dst="/root/${item}"

  #if [[ -d "${src}" ]]; then
    echo "Adding ${src} -> ${dst}"
    printf 'bindfs#%s %s fuse force-user=ndsadmin,force-group=ndsadmin,perms=0700,create-for-user=ndsadmin,create-for-group=ndsadmin,chmod-normal,nonempty,x-systemd.requires-mounts-for=/home/ndsadmin/.dotfiles,x-systemd.automount,nofail 0 0\n' \
      "${src}" "${dst}" | sudo tee -a /etc/fstab >/dev/null
    sudo mkdir -p "${src}" "${dst}" # ensure it exists for the mount to work
  #else
  #  echo "Skipping ${src}, does not exist"
  #fi
done
echo -e "\n" | sudo tee -a /etc/fstab >/dev/null
