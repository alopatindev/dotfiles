#!/bin/bash

cd $(tmux display-message -p -F "#{pane_current_path}" -t0 | sed 's!'${HOME}'/.private/work/!'${HOME}'/work/!')
${SHELL}
