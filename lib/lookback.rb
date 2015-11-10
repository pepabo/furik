require 'octokit'
require 'optparse'
require 'lookback/core_ext/string'
require 'lookback/dotenv'
require 'lookback/pull_requests'
require 'lookback/events'

module Lookback
  class << self
    def default_octokit_option
      {
        auto_paginate: true,
        per_page: 100
      }
    end

    def gh_options
      default_octokit_option.merge(
        access_token: ENV['GITHUB_ACCESS_TOKEN']
      )
    end

    def ghe_options
      default_octokit_option.merge(
        access_token: ENV['GITHUB_ENTERPRISE_ACCESS_TOKEN'],
        api_endpoint: 'https://YOUR-GITHUB-URL/api/v3/'
      )
    end

    def gh_client
      Octokit::Client.new gh_options
    end

    def ghe_client
      Octokit::Client.new ghe_options
    end

    def events_with_grouping(gh: true, ghe: true, from: nil, to: nil, &block)
      events = []

      if gh
        gh_events = Events.new(gh_client).events_with_grouping(from, to, &block)
        events.concat gh_events if gh_events.is_a?(Array)
      end

      if ghe
        ghe_events = Events.new(ghe_client).events_with_grouping(from, to, &block)
        events.concat ghe_events if ghe_events.is_a?(Array)
      end

      events
    end

    def pull_requests(gh: true, ghe: true, &block)
      pulls = []

      if gh
        gh_pulls = PullRequests.new(gh_client).all(&block)
        pulls.concat gh_pulls if gh_pulls.is_a?(Array)
      end

      if ghe
        ghe_pulls = PullRequests.new(ghe_client).all(&block)
        pulls.concat ghe_pulls if ghe_pulls.is_a?(Array)
      end

      pulls
    end
  end
end
