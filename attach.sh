#!/bin/bash
SESSION_ID=${1:-1}
SESSION_NAME="agy_${SESSION_ID}"

export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US:en
unset GODEBUG

EXTRA_ARGS=$(jq -r '.extra_args // empty' /data/options.json 2>/dev/null || true)

# Create tmux session if it doesn't exist yet, with bash fallback to prevent exit loops
if ! tmux -f /etc/tmux.conf has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux -f /etc/tmux.conf new-session -d -s "$SESSION_NAME" -c "/homeassistant" "bash -c 'unset GODEBUG; /usr/local/bin/agy ${EXTRA_ARGS:+$EXTRA_ARGS}; exec bash'"
fi

# Attach to the tmux session
exec tmux -f /etc/tmux.conf attach-session -t "$SESSION_NAME"

