# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module ProjectGallery
  ORG = 'htwk-prodlog'
  SITE_REPO = "#{ORG}.github.io"
  PER_PAGE = 100

  class Generator < Jekyll::Generator
    safe true

    def generate(site)
      repos = []
      page = 1

      loop do
        uri = URI("https://api.github.com/orgs/#{ORG}/repos?type=public&per_page=#{PER_PAGE}&page=#{page}")
        request = Net::HTTP::Get.new(uri)
        request['User-Agent'] = 'htwk-prodlog.github.io Jekyll build'
        request['Accept'] = 'application/vnd.github+json'
        request['Authorization'] = "Bearer #{ENV['GITHUB_TOKEN']}" unless ENV['GITHUB_TOKEN'].to_s.empty?

        response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: 10, read_timeout: 20) do |http|
          http.request(request)
        end
        raise "GitHub repository lookup failed (HTTP #{response.code}): #{response.body}" unless response.is_a?(Net::HTTPSuccess)

        batch = JSON.parse(response.body)
        raise 'Unexpected GitHub repository response' unless batch.is_a?(Array)

        repos.concat(batch)
        break if batch.length < PER_PAGE

        page += 1
      end

      site.data['projects'] = repos.filter_map do |repo|
        next unless repo['has_pages'] == true && repo['full_name'] != "#{ORG}/#{SITE_REPO}"

        {
          'name' => repo.fetch('name'),
          'description' => repo['description'],
          'language' => repo['language'],
          'repo_url' => repo.fetch('html_url'),
          'pages_url' => "https://#{ORG}.github.io/#{repo.fetch('name')}/"
        }
      end.sort_by { |project| project['name'].downcase }
    end
  end
end
