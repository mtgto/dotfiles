#!/usr/bin/env ruby
#
# Displays model name, context window usage, and rate limit in the status line.
#
# Usage: Add the following to ~/.claude/settings.json
#
#   "statusLine": {
#     "type": "command",
#     "command": "~/.claude/statusline.rb"
#   }
#
require 'json'

input = JSON.parse($stdin.read)
model = input['model']['display_name']

# Context window usage (0-100 float, may be nil before first API call)
used_percentage = input['context_window']['used_percentage']

def usage_bar(percentage)
  return '░' * 10 + ' --%' unless percentage
  used_blocks = (percentage / 10.0).floor
  color = case percentage
          when  0...70 then "\e[32m"  # green  — normal
          when 70...90 then "\e[33m"  # yellow — warning
          else              "\e[31m"  # red    — critical
          end
  "#{color}#{'▓' * used_blocks}\e[0m#{'░' * (10 - used_blocks)} #{percentage.to_i}%"
end

context_str = usage_bar(used_percentage)

# Rate limit (optional — only present for Claude.ai subscribers after first API response)
rate_str = ''
five_hour = input.dig('rate_limits', 'five_hour')
if five_hour
  rate_used = five_hour['used_percentage']
  rate_reset_at = five_hour['resets_at']

  if rate_used
    reset_str = rate_reset_at ? " reset:#{Time.at(rate_reset_at).strftime('%H:%M')}" : ''
    rate_str = " | 5h:#{usage_bar(rate_used)}#{reset_str}"
  end
end

puts "\e[36m[#{model}]\e[0m #{context_str}#{rate_str}"
