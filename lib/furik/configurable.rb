require 'yaml'
require 'pit'

module Furik
  module Configurable
    class << self
      def hub_config_path
        ENV['HUB_CONFIG_PATH'] || "#{Dir.home}/.config/hub"
      end

      def token_generate_path
        '/settings/tokens/new'
      end

      def token_by_hub(host = 'github.com')
        hub_config = YAML.load_file hub_config_path
        if !hub_config[host].nil? && !hub_config[host].empty?
          hub_config[host].last['oauth_token']
        end
      end

      def token_by_pit(host = 'github.com')
        Pit.get(host, require: {
          'access_token' => "#{host} Access Token? (https://#{host}#{token_generate_path})"
        })['access_token']
      end

      def github_access_token
        token_by_hub || token_by_pit
      end

      def github_enterprise_host
        ENV['GITHUB_ENTERPRISE_HOST'] || github_enterprise_host_by_pit
      end

      def github_enterprise_host_by_pit
        Pit.get('furik', require: {
          'github_enterprise_host' => 'Github:Enterprise Host?(ex: your.domain.com)'
        })['github_enterprise_host']
      end

      def github_enterprise_access_token
        token_by_hub(github_enterprise_host) || token_by_pit(github_enterprise_host)
      end

      def default_octokit_options
        {
          auto_paginate: true,
          per_page: 100
        }
      end

      def github_octokit_options
        default_octokit_options.merge(
          access_token: github_access_token
        )
      end

      def github_enterprise_octokit_options
        default_octokit_options.merge(
          access_token: github_enterprise_access_token,
          api_endpoint: "https://#{github_enterprise_host}/api/v3/"
        )
      end
    end
  end
end
