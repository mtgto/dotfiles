#!/usr/bin/env ruby
# Original: https://github.com/herdrdev/herdr/blob/master/src/integration/assets/claude/herdr-agent-state.sh
# HERDR_INTEGRATION_ID=claude
# HERDR_INTEGRATION_VERSION=11
#
# Usage: Add the following to ~/.claude/settings.json
#
#   "hooks": {
#     "SessionStart": [{ "hooks": [{ "type": "command", "command": "~/.claude/hooks/herdr-agent-state.rb session" }] }]
#   }

require 'json'
require 'socket'

# v0.8+: action argument required; only 'session' is handled
action = ARGV[0].to_s
exit 0 unless action == 'session'

exit 0 unless ENV['HERDR_ENV'] == '1'
exit 0 if ENV['HERDR_SOCKET_PATH'].to_s.empty?
exit 0 if ENV['HERDR_PANE_ID'].to_s.empty?

source      = 'herdr:claude'
pane_id     = ENV['HERDR_PANE_ID']
socket_path = ENV['HERDR_SOCKET_PATH']

hook_input = begin
  raw = $stdin.read
  raw.strip.empty? ? {} : JSON.parse(raw)
rescue StandardError
  {}
end

# Skip Cursor
exit 0 if ENV.key?('CURSOR_VERSION') || hook_input.key?('cursor_version')

hook_event_name = hook_input['hook_event_name'].to_s

# Only handle SessionStart events
exit 0 unless hook_event_name == 'SessionStart'

is_subagent = !hook_input['agent_id'].to_s.empty?
exit 0 if is_subagent

session_id       = hook_input['session_id']
agent_session_id = session_id.is_a?(String) && !session_id.empty? ? session_id : nil
exit 0 unless agent_session_id

transcript_path    = hook_input['transcript_path']
agent_session_path = transcript_path.is_a?(String) && !transcript_path.empty? ? transcript_path : nil

session_start_source = hook_input['source']
session_start_source = nil unless session_start_source.is_a?(String) && !session_start_source.to_s.empty?

request_id = "#{source}:#{(Time.now.to_f * 1000).to_i}:#{rand(1_000_000).to_s.rjust(6, '0')}"
report_seq  = Process.clock_gettime(Process::CLOCK_REALTIME, :nanosecond)

params = {
  'pane_id'          => pane_id,
  'source'           => source,
  'agent'            => 'claude',
  'seq'              => report_seq,
  'agent_session_id' => agent_session_id,
}
params['agent_session_path']   = agent_session_path   if agent_session_path
params['session_start_source'] = session_start_source if session_start_source

request = {
  'id'     => request_id,
  'method' => 'pane.report_agent_session',
  'params' => params,
}

begin
  client = Socket.new(Socket::AF_UNIX, Socket::SOCK_STREAM)
  client.connect(Socket.pack_sockaddr_un(socket_path))
  client.setsockopt(Socket::SOL_SOCKET, Socket::SO_SNDTIMEO, [0, 500_000].pack('l_2'))
  client.setsockopt(Socket::SOL_SOCKET, Socket::SO_RCVTIMEO, [0, 500_000].pack('l_2'))
  client.write(JSON.generate(request) + "\n")
  begin
    client.recv(4096)
  rescue StandardError
    # ignore read errors
  end
  client.close
rescue StandardError
  # ignore connection errors
end
