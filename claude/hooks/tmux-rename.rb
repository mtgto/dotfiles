#!/usr/bin/env ruby
#
# Renames the tmux window based on Claude Code hook events.
#
# Usage: Add the following to ~/.claude/settings.json
#
#   "hooks": {
#     "SessionStart":     [{ "hooks": [{ "type": "command", "command": "~/.claude/hooks/tmux-rename.rb" }] }],
#     "UserPromptSubmit": [{ "hooks": [{ "type": "command", "command": "~/.claude/hooks/tmux-rename.rb" }] }],
#     "Notification":     [{ "hooks": [{ "type": "command", "command": "~/.claude/hooks/tmux-rename.rb" }] }],
#     "PermissionRequest":[{ "hooks": [{ "type": "command", "command": "~/.claude/hooks/tmux-rename.rb" }] }],
#     "Stop":             [{ "hooks": [{ "type": "command", "command": "~/.claude/hooks/tmux-rename.rb" }] }],
#     "SessionEnd":       [{ "hooks": [{ "type": "command", "command": "~/.claude/hooks/tmux-rename.rb" }] }]
#   }
#
require 'json'

exit unless ENV['TMUX'] && ENV['TMUX_PANE']

input = JSON.parse($stdin.read)
basename = File.basename(input['cwd'])
pane = ENV.fetch('TMUX_PANE')

case input['hook_event_name']
when 'SessionStart', 'Stop'
  system("tmux rename-window -t #{pane} \"✨ #{basename}\"")
when 'UserPromptSubmit'
  system("tmux rename-window -t #{pane} \"⚡ #{basename}\"")
when 'Notification', 'PermissionRequest'
  system("tmux rename-window -t #{pane} \"💬 #{basename}\"")
when 'SessionEnd'
  system("tmux set-window-option -t #{pane} automatic-rename on")
end
