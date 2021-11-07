#!/bin/bash

cd "$(tmux display-message -p -F "#{pane_current_path}" -t0)"
${SHELL}
