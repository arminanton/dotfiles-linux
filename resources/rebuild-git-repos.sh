#!/bin/bash

main_path="projects"
cd "${main_path}"

echo -e "Loading folders..."
for i in $(ls -d */); do
  if [[ -d "${main_path}/${i%%/}/.git" ]]; then
    cd "${i%%/}"
    git_url=$(
      git config --get remote.origin.url |
        sed 's/git@//' |
        sed 's/:/\//' |
        sed 's/.git//' |
        sed 's/ssh\/\/\///'
    )

    echo -e "\n${git_url}"
    read -p 'Press enter to initiate.'

    cd ..
    sudo rm -rf "${i%%/}"
    gh repo clone $git_url
  fi
done

echo -e "\nDone!"