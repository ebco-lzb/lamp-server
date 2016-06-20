#!/bin/bash

repos=(
  "/opt/lamp-server"
  "/home/homepage/public_html"
  "/home/homepage.la-z-boyga.com/public_html"
)

echo "Checking" ${#repos[@]} "repositories for updates"


for repo in "${repos[@]}"
do
  echo "Checking" ${repo}
  cd "${repo}"

  status=$([ "`git log --pretty=%H ...refs/heads/master^ | head -n 1`" = "`git ls-remote origin -h refs/heads/master |cut -f1`" ] && echo "up to date" || echo "not up to date")

  if [ "$status" == "up to date" ]; then
     echo $'up to date\n'
  else
     echo $'not up to date\n'
     echo $'Pulling Changes For ${repo}\n'
     git reset --hard
     git pull
  fi
done
