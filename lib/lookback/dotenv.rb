require 'dotenv'
require 'highline'

Dotenv.load

module Dotenv
  def self.add(key_value, filename = nil)
    filename = File.expand_path(filename || '.env')
    f = File.open(filename, 'a')
    f.puts key_value
    key, value = key_value.split('=')
    ENV[key] = value
  end
end

unless ENV['GITHUB_ACCESS_TOKEN']
  generate = 'https://github.com/settings/tokens/new'
  token = HighLine.new.ask("GitHub Access Token? (generate: #{generate})")
  Dotenv.add "GITHUB_ACCESS_TOKEN=#{token}"
end

unless ENV['GITHUB_ENTERPRISE_ACCESS_TOKEN']
  generate = 'https://YOUR-GITHUB-URL/settings/tokens/new'
  token = HighLine.new.ask("GitHub Enterprise Access Token? (generate: #{generate})")
  Dotenv.add "GITHUB_ENTERPRISE_ACCESS_TOKEN=#{token}"
end
