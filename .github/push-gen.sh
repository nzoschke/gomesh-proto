#!/bin/bash

git config user.email "gen@example.com"
git config user.name  "gen"

git rm -rf .github/
git rm -rf gen/
git add gen/
git commit -m "gen ${GITHUB_SHA:0:7}"

git push https://github.com/nzoschke/gomesh-interface.git ${GITHUB_REF}:${GITHUB_REF}-gen
