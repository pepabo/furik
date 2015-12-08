require 'test_helper'

class FurikTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Furik::VERSION
  end

  def test_gh_client_returns_octokit_client
    assert_equal Furik.gh_client.class, Octokit::Client
  end

  def test_ghe_client_returns_octokit_client
    assert_equal Furik.ghe_client.class, Octokit::Client
  end

  def test_events_with_grouping_empty_array
    assert_equal Furik.events_with_grouping(gh: false, ghe: false), []
  end

  def test_pull_requests_returns_empty_array
    assert_equal Furik.pull_requests(gh: false, ghe: false), []
  end
end
