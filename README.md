# Furik

Furik is summary generator for your GitHub activities.

## Installation

Install it yourself as:

    $ gem install furik

## Usage

You can show GitHub activity while one day.

    $ furik activity

Output example is here:

```
% furik activity
Today's Activities
-

### ruby/rubyspec

- [pull_request](https://github.com/ruby/rubyspec/pull/158): Set Net::FTP.default_passive to false.
- [comment](https://github.com/ruby/rubyspec/pull/158#issuecomment-155703551): :+1: (Set Net::FTP.default_passive t...)

### ruby/ruby

- [pull_request](https://github.com/ruby/ruby/pull/1091): Fix typo, double 'means'
(snip)
```

If you want to show GitHub and GitHub Enterprise activities, You need to add `-l` option to `furik` command.

    $ furik activity -l

furik supports to store authentication via Pit. You are asked GitHub (and GitHub Enterprise) token from furik.

Pit sotred your token to `~/.pit/default.yaml` by default. You can confirm or modify this yaml.

```sh
% cat ~/.pit/default.yaml
---
github.com:
  access_token: your_token
your.github-enterpise.host:
  access_token: your_enterprise_token
furik:
  github_enterprise_host: your.github-enterpise.host
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec furik` to use the gem in this directory, ignoring other installed copies of this gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pepabo/furik.
