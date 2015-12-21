require 'test_helper'

class PullRequestsTest < Minitest::Test
  def test_all_repo_names
    stub_get 'user'
    stub_get 'user/repos?per_page=100'
    stub_get 'user/orgs?per_page=100'
    stub_get 'orgs/github/repos?per_page=100'

    instance = Furik::PullRequests.new(Furik.gh_client)
    assert_equal instance.all_repo_names, ['octocat/Hello-World']
  end

  def test_user_repo_names_returns_repos
    stub_get 'user'
    stub_get 'repos?per_page=100'
    stub_get 'user/repos?per_page=100'

    instance = Furik::PullRequests.new(Furik.gh_client)
    assert_equal instance.user_repo_names, ['octocat/Hello-World']
  end

  def test_user_orgs_names
    stub_get 'user'
    stub_get 'user/orgs?per_page=100'

    instance = Furik::PullRequests.new(Furik.gh_client)
    assert_equal instance.user_orgs_names, ['github']
  end

  def test_org_repo_names
    stub_get 'user'
    stub_get 'orgs/github/repos?per_page=100'

    instance = Furik::PullRequests.new(Furik.gh_client)
    assert_equal instance.org_repo_names('github'), ['octocat/Hello-World']
  end

  def test_orgs_repo_names
    stub_get 'user'
    stub_get 'user/orgs?per_page=100'
    stub_get 'orgs/github/repos?per_page=100'

    instance = Furik::PullRequests.new(Furik.gh_client)
    assert_equal instance.orgs_repo_names, ['octocat/Hello-World']
  end
end
