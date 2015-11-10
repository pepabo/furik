module Furik
  class Events
    def initialize(client)
      @client = client
      @login = client.login
    end

    def events_with_grouping(from, to, &block)
      @client.user_events(@login).each.with_object({}) { |event, memo|
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
