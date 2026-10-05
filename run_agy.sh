#!/bin/bash
unset GODEBUG
EXTRA_ARGS=$(jq -r '.extra_args // empty' /data/options.json 2>/dev/null || true)
sleep 0.5
exec /usr/local/bin/agy ${EXTRA_ARGS:+$EXTRA_ARGS} "$@"
