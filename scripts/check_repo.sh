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
     git reset --hard
     git pull
done

