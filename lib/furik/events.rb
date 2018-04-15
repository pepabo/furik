module Furik
  class Events
    def initialize(client, options: {})
      @client = client
      @login = client.login
      @options = options
    end

    def events_with_grouping(from, to, &block)
      @client.user_events(@login).each.with_object({}) { |event, memo|
        next if ignore_event?(event)
        if event && aggressives.include?(event.type)
          if from <= event.created_at.localtime.to_date && event.created_at.localtime.to_date <= to
            memo[event.repo.name] ||= []
            memo[event.repo.name] << event
          end
        end
      }.each do |repo, events|
        block.call(repo, events) if block
      end
    end

    def ignore_event?(event)
      ignore_private_repos = @options[:ignore_private_repos]
      
      return false unless ignore_private_repos

      unless event.public
        patterns = ignore_private_repos.fetch('whitelist', [])
        
        return !patterns.any?{|p| event.repo.name =~ /#{p}/ }
      end
  
      return true
    end

    def aggressives
      %w(
        IssuesEvent
        PullRequestEvent
        PullRequestReviewCommentEvent
        IssueCommentEvent
        CommitCommentEvent
      )
    end
  end
end
