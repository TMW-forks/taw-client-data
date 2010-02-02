#!/bin/sh
#
# silly script to make tmw like update zips from git revisions

if [ "${1}x" = "x" ]; then
	echo "Usage: ${0} FROMREV TOREV"
	echo "if TOREV is omitted it defaults to HEAD"
	exit 0

elif [ "${2}" = "HEAD" -o "${2}x" = "x" ]; then
	headrev=`git log --pretty=oneline -n 1 | awk '{print $1}'`
else
	headrev=$2
fi

u1=`echo ${1} | cut -c 1-7`
u2=`echo ${headrev} | cut -c 1-7`

git log --name-status ${1}..${headrev} | awk '/^(A|M)\t/ {print $2}' | sort | uniq | xargs zip -9 -r update-${u1}..${u2}.zip
