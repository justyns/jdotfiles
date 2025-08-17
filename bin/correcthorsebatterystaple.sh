#!/bin/bash

# source: https://gist.github.com/treyka/3999558
# for generating xkcd-style passwords

WORDCOUNT="${1:-4}"

MIN_WORD_LENGTH=4
MAX_WORD_LENGTH=7
LANGUAGE='en'

for i in $(seq 1 ${WORDCOUNT}); do
    echo -n $(aspell -d "${LANGUAGE}" dump master \
        | grep -E "^[[:alpha:]]{$MIN_WORD_LENGTH,$MAX_WORD_LENGTH}$" \
        | shuf | tail -n 1 | tr [:upper:] [:lower:])
    echo -n " "
done
