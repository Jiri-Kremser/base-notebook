#!/usr/bin/env bash

checkUrl() {
  [[ $# -lt 1 ]] && echo "usage: checkUrl <url>" && return
  echo $1
  http_code=`curl -s -o /dev/null -w "%{http_code}" $1`
  [[ "$http_code" -lt "200" || "$http_code" -gt "299" ]] && exit 1
}

# this endpoint should be reachable even without auth
checkUrl "http://localhost:8888/api"

# check this endpoint if the authN is completely disabled
if [[ "$JUPYTER_NOTEBOOK_DISABLE_TOKEN" == "true" && -z "$JUPYTER_NOTEBOOK_PASSWORD" ]]; then
  checkUrl "http://localhost:8888/tree"
fi

exit 0
