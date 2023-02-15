#!/bin/bash
echo -e "\n\nSeems like it is your first time authenticating to github enterprise.\n"
echo "The script will prompt to use an existing key or to create a new one."
echo "And also to use or not a password. Then will request to login at the"
echo "browser. Copy and paste the url given and insert the generated code."
echo -e "Once you accept the login, your git will be fully authenticated.\n"
echo "Y  " | gh auth login --hostname ghe.intra.nudatasecurity.com --git-protocol ssh --web
gh auth setup-git
echo -e ""
{
  cat <<CONTENT
#!/bin/bash
echo -e "\n\nAre you trying to change your authentication to github enterprise?!\nSeems like you do.\n\n"
echo "The script will prompt to use an existing key or to create a new one."
echo "And also to use or not a password. Then will request to login at the"
echo "browser. Copy and paste the url given and insert the generated code."
echo -e "Once you accept the login, your git will be fully authenticated.\n"
gh auth login --hostname ghe.intra.nudatasecurity.com --git-protocol ssh --web
gh auth setup-git
echo -e ""
CONTENT
} >~/user-github-auth.sh
