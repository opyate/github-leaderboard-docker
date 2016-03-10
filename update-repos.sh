#!/usr/bin/env bash
# TODO currently only 'orgs'; also support 'users'
set -e

command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it's not installed.  Aborting."; exit 1; }
[ $# -eq 0 ] && echo "Please specify at least one repo." && exit 2;
: ${GITHUB_TOKEN?"Need to set GITHUB_TOKEN"}

mkdir -p .cache
ALL_REPOS=.cache/all.json
# seed
rm -rf $ALL_REPOS
echo "[]" > $ALL_REPOS

for REPO in $@ ; do
  if [ ! -e .cache/$REPO ] ; then
    curl "https://api.github.com/orgs/${REPO}/repos?type=private&per_page=500" -H "Authorization: token $GITHUB_TOKEN" > .cache/$REPO
  fi
  jq -s '.[0] + .[1]' $ALL_REPOS .cache/$REPO > ${ALL_REPOS}temp
  mv ${ALL_REPOS}temp ${ALL_REPOS}
done

CSV_REPOS=$(cat $ALL_REPOS | jq '.[].full_name' | sed "s/$/,/g" | tr -d '\040\011\012\015')
TEMP=$(mktemp -d -t github-leaderboard-XXXXXX)
cp config.template.js ${TEMP}/config.js
sed -i -e "s#%PROJECTS%#${CSV_REPOS}#" ${TEMP}/config.js
sed -i -e "s/%GITHUB_TOKEN%/\"$GITHUB_TOKEN\"/" ${TEMP}/config.js
mv ${TEMP}/config.js ./config.js
rm -rf ${TEMP}
