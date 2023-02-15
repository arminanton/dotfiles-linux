#!/bin/bash

main_path="/mnt/devvm/projects"
cd "${main_path}"

echo "Loading paths..."
#find . -type f -print0 | xargs -0 grep -l '"../projects/' | grep "composer.json" > found-paths

function read_file() {
    IFS=''
    local filepath
    read -d '' filepath <"${1}"
    echo -e "${filepath}"
}

list_paths=$(read_file found-paths | sed 's/composer.json//')
echo "${list_paths}" > found-paths
new_path=""
echo "" > symlinked-paths
if [[ -n "${list_paths}" ]]; then
    exec 3< found-paths
    while read -u 3 line; do
        #read -p 'Press enter.'
        new_path=$(
          echo "${main_path}/${line}" | sed 's/\.\///'
        )
        #echo -e "\n${new_path}"
        if [[ -d "${new_path}" ]]; then
            cd "${new_path}"
            cd ..
            new_path=$(pwd)
            new_path="${new_path}/projects"
            if [[ -e "${new_path}" ]] || [[ -L "${new_path}" ]]; then
                sudo rm "${new_path}"
            fi
            echo -e "\nSymlink to: ${new_path}"
            ln -s "${main_path}" "${new_path}"
            #ls -la "${new_path}"
            cd "${main_path}"
            echo "${new_path}" >> symlinked-paths
        else
            echo -e "\nDirectory does not exists: ${new_path}"
        fi
    done
fi
echo -e "\nDone!"
