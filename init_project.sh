#!/bin/bash

given_name=$1
[[ -z "$given_name" ]] && echo "Usage: $0 new_project_name" && exit 1

#replace all default project name to the given project name
grep -r pyempty . | awk -F':' '{print $1}' | sort -u | grep -v Binary | grep -v init_project.sh | xargs sed -i .new "s/pyempty/$given_name/g"

#rename file include default project name to the given project name
for foo in $(find . -type f -name '*pyempty*' | grep -v '\.new');do
    echo "mv $foo $(echo $foo | sed "s/pyempty/$given_name/g")"
    mv $foo $(echo $foo | sed "s/pyempty/$given_name/g")
done

for foo in $(find . -type d -name '*pyempty*' | grep -v '\.new');do
    echo "mv $foo $(echo $foo | sed "s/pyempty/$given_name/g")"
    mv $foo $(echo $foo | sed "s/pyempty/$given_name/g")
done
