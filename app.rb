# encoding: utf-8
require 'base64'
require 'bundler'
Bundler.require

url = "https://github.com/haya14busa/dotfiles/blob/master/.vimrc"

# convert to raw url without octokit
raw_url = url.match(/^(https?:\/\/)(github.com\/[^\/]+\/[^\/]+\/)blob\/(.+)$/){|m|
  "#{m[1]}raw.#{m[2]}#{m[3]}"
}


# raw content using octokit
repo = Octokit::Repository.from_url url
content = url.match /^#{repo.url}\/blob\/([^\/]+)\/(.+)$/ do |m|
  branch = m[1]
  path = m[2]
  content = Octokit.contents repo, path: path, ref: branch
  Base64.decode64 content.content
end

puts "RAW_URL: #{raw_url}"
puts "CONTENT: #{content[0,100].gsub("\n",'')}..."
