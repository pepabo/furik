$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'furik'

require 'minitest/autorun'
require 'webmock/minitest'

module Furik::Configurable
  class << self
    def token_by_pit(host = 'github.com')
      'x' * 40
    end
  end
end

ENV['GITHUB_ENTERPRISE_HOST'] = 'your.domain.com'

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def json_response(file)
  {
    status: 200,
    headers: { :content_type => 'application/json; charset=utf-8' },
    body: fixture(file)
  }
end

def github_url(url)
  return url if url =~ /^http/
  url = File.join(Octokit.api_endpoint, url)
  uri = Addressable::URI.parse(url)
  uri.path.gsub!("v3//", "v3/")
  uri.to_s
end

def stub_get(endpoint)
  stub_request(:get, github_url(endpoint)).
    to_return json_response("#{endpoint}.json")
end
