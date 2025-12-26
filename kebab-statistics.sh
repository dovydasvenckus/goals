#!/usr/bin/env sh 

# Usage: ./count_kebabs.sh goals.json
INPUT_FILE="$1"

if [[ -z "$INPUT_FILE" ]]; then
  echo "Usage: $0 <json-file>"
  exit 1
fi

jq -r '
  .goals[]
  | select(.name | ascii_downcase | contains("kebab"))
  | .data.entries[]
  | .value
' "$INPUT_FILE" \
| tee >(wc -l | awk '{print "\nTotal: :", $1}' >&2) \
| sort \
| uniq -c \
| sort -nr

