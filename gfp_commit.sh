set -x
echo "commit is " $1
#last_commit=`git log --pretty=format:"%h [%an] %s %cd" | grep "$1" -A 1` 
last_commit=`git log --pretty=format:"%h [%an] %s %cd" | grep "$1" -A 1 | awk '{ print $1 }' | grep -v "$1"` 

echo $last_commit

git format-patch "$last_commit".."$1"

