#!/bin/bash

git config user.email "gen@example.com"
git config user.name  "gen"
git remote -v

git rm -rf .github/
git add gen/
git commit -m "gen ${GITHUB_SHA:0:7}"

git push -f https://nzoschke:${PUSH_TOKEN}@github.com/nzoschke/gomesh-interface.git ${GITHUB_REF}:${GITHUB_REF}-gen
