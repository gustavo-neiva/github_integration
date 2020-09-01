require 'rails_helper'

describe Domain::Repository do
  let(:github_hash) do
    {
      "id": 2832871,
      "node_id": "MDEwOlJlcG9zaXRvcnkyODMyODcx",
      "name": "t",
      "full_name": "sferik/t",
      "private": false,
      "owner": {
          "login": "sferik",
          "id": 10308,
          "node_id": "MDQ6VXNlcjEwMzA4",
          "avatar_url": "https://avatars1.githubusercontent.com/u/10308?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/sferik",
          "html_url": "https://github.com/sferik",
          "followers_url": "https://api.github.com/users/sferik/followers",
          "following_url": "https://api.github.com/users/sferik/following{/other_user}",
          "gists_url": "https://api.github.com/users/sferik/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/sferik/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/sferik/subscriptions",
          "organizations_url": "https://api.github.com/users/sferik/orgs",
          "repos_url": "https://api.github.com/users/sferik/repos",
          "events_url": "https://api.github.com/users/sferik/events{/privacy}",
          "received_events_url": "https://api.github.com/users/sferik/received_events",
          "type": "User",
          "site_admin": false
      },
      "html_url": "https://github.com/sferik/t",
      "description": "A command-line power tool for Twitter.",
      "fork": false,
      "url": "https://api.github.com/repos/sferik/t",
      "forks_url": "https://api.github.com/repos/sferik/t/forks",
      "keys_url": "https://api.github.com/repos/sferik/t/keys{/key_id}",
      "collaborators_url": "https://api.github.com/repos/sferik/t/collaborators{/collaborator}",
      "teams_url": "https://api.github.com/repos/sferik/t/teams",
      "hooks_url": "https://api.github.com/repos/sferik/t/hooks",
      "issue_events_url": "https://api.github.com/repos/sferik/t/issues/events{/number}",
      "events_url": "https://api.github.com/repos/sferik/t/events",
      "assignees_url": "https://api.github.com/repos/sferik/t/assignees{/user}",
      "branches_url": "https://api.github.com/repos/sferik/t/branches{/branch}",
      "tags_url": "https://api.github.com/repos/sferik/t/tags",
      "blobs_url": "https://api.github.com/repos/sferik/t/git/blobs{/sha}",
      "git_tags_url": "https://api.github.com/repos/sferik/t/git/tags{/sha}",
      "git_refs_url": "https://api.github.com/repos/sferik/t/git/refs{/sha}",
      "trees_url": "https://api.github.com/repos/sferik/t/git/trees{/sha}",
      "statuses_url": "https://api.github.com/repos/sferik/t/statuses/{sha}",
      "languages_url": "https://api.github.com/repos/sferik/t/languages",
      "stargazers_url": "https://api.github.com/repos/sferik/t/stargazers",
      "contributors_url": "https://api.github.com/repos/sferik/t/contributors",
      "subscribers_url": "https://api.github.com/repos/sferik/t/subscribers",
      "subscription_url": "https://api.github.com/repos/sferik/t/subscription",
      "commits_url": "https://api.github.com/repos/sferik/t/commits{/sha}",
      "git_commits_url": "https://api.github.com/repos/sferik/t/git/commits{/sha}",
      "comments_url": "https://api.github.com/repos/sferik/t/comments{/number}",
      "issue_comment_url": "https://api.github.com/repos/sferik/t/issues/comments{/number}",
      "contents_url": "https://api.github.com/repos/sferik/t/contents/{+path}",
      "compare_url": "https://api.github.com/repos/sferik/t/compare/{base}...{head}",
      "merges_url": "https://api.github.com/repos/sferik/t/merges",
      "archive_url": "https://api.github.com/repos/sferik/t/{archive_format}{/ref}",
      "downloads_url": "https://api.github.com/repos/sferik/t/downloads",
      "issues_url": "https://api.github.com/repos/sferik/t/issues{/number}",
      "pulls_url": "https://api.github.com/repos/sferik/t/pulls{/number}",
      "milestones_url": "https://api.github.com/repos/sferik/t/milestones{/number}",
      "notifications_url": "https://api.github.com/repos/sferik/t/notifications{?since,all,participating}",
      "labels_url": "https://api.github.com/repos/sferik/t/labels{/name}",
      "releases_url": "https://api.github.com/repos/sferik/t/releases{/id}",
      "deployments_url": "https://api.github.com/repos/sferik/t/deployments",
      "created_at": "2011-11-23T02:59:48Z",
      "updated_at": "2020-08-28T19:43:28Z",
      "pushed_at": "2020-07-08T06:29:06Z",
      "git_url": "git://github.com/sferik/t.git",
      "ssh_url": "git@github.com:sferik/t.git",
      "clone_url": "https://github.com/sferik/t.git",
      "svn_url": "https://github.com/sferik/t",
      "homepage": "http://sferik.github.com/t",
      "size": 3549,
      "stargazers_count": 5109,
      "watchers_count": 5109,
      "language": "Ruby",
      "has_issues": true,
      "has_projects": true,
      "has_downloads": true,
      "has_wiki": true,
      "has_pages": true,
      "forks_count": 405,
      "mirror_url": nil,
      "archived": false,
      "disabled": false,
      "open_issues_count": 171,
      "license": {
          "key": "mit",
          "name": "MIT License",
          "spdx_id": "MIT",
          "url": "https://api.github.com/licenses/mit",
          "node_id": "MDc6TGljZW5zZTEz"
      },
      "forks": 405,
      "open_issues": 171,
      "watchers": 5109,
      "default_branch": "master",
      "score": 1.0
    }.with_indifferent_access
  end

  describe '.build_from_hash' do
    it 'creates a repository object' do
      repository = described_class.build_from_hash(github_hash)
      expect(repository.class).to eq(Domain::Repository)
      expect(repository.stars).to eq(github_hash.dig("stargazers_count"))
    end
  end

  describe '#to_hash' do
    let(:result_hash) {
      {:full_name=>"sferik/t", :description=>"A command-line power tool for Twitter.", :stars=>5109, :forks=>405, :author=>"sferik"}
    }
    it 'creates a hash from objects attributes' do
      repository = described_class.new(result_hash)
      expect(repository.to_hash).to eq(result_hash)
    end
  end
end
