#!/bin/bash
# Run bash twitter_search.sh keyword_file.txt twitter_usernames

while read var; do
  echo "Searching for $var"
  wget -q "https://twitter.com/i/search/typeahead.json?q=$var"
  cat typeahead.json?q=$var | jq -r '.users | to_entries[] | .value.screen_name' >> $2.txt
  rm -f typeahead.json?q=$var
  wc -l < $2.txt
done < $1;
cat $2.txt | sort | uniq >> $2.unique.list
echo "Results:"
wc -l ./$2.unique.list
rm -f $2.txt
