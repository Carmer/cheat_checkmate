require "text"
require "faraday"
require "base64"
require 'json'
require 'awesome_print'

class App
  attr_reader :flagged_username,
              :flagged_repo,
              :flagged_file_name,
              :comparison_username,
              :comparison_repo,
              :comparison_file_name

  def initialize
    @flagged_username = ARGV[0]
    @flagged_repo = ARGV[1]
    @flagged_file_name = ARGV[2]
    @comparison_username = ARGV[3]
    @comparison_repo = ARGV[4]
    @comparison_file_name = ARGV[5]
    @connection = Faraday.new url: "https://api.github.com/repos/"
    @outcome = {}
  end

  def run
    get_repos
  end

  private


    def get_repos
      @student_flagged ||= check_for_content(get_flagged_response)
      @comparison_flagged ||=  check_for_content(get_comparison_response)

      @student_flagged.map.with_index do |line, index|
        @comparison_flagged.each do |flag|
          if line && flag && line != "\n" && flag != "\n" && Text::Levenshtein.distance(line, flag) <= 3
            format_flagged_line(line, index) if @comparison_flagged.include?(line)
          end
        end
      end

      explain_output
    end

  def explain_output
    if @outcome.empty?
      puts "Clean Code - No Collisions"
    else
      puts "Collisions: #{@outcome.length}\n================"
      ap @outcome
    end
  end


  def warn_directions!
    "\nWARNING:\nPlease check inputs and try again: \n\nUSAGE:\nruby app.rb :1flagged_github_username :2flagged_github_repositoty_name :3flagged_file_name :4comparison_github_username :5comparison_github_repositoty_name :6comparison_file_name\n\n\n"
  end

  def check_for_content(repo_content)
    if repo_content
      repo_content.split("\n")
    else
      return puts warn_directions!
    end
  end

  def format_flagged_line(line, index)
    @outcome["Line: #{index + 1}"] = "  #{line}" unless line.empty?
  end

  def get_flagged_response
    get_repo(flagged_username, flagged_repo, flagged_file_name)
  end

  def get_comparison_response
    get_repo(comparison_username, comparison_repo, comparison_file_name)
  end

  def get_repo(username, repo, file)

    comparison_response = @connection.get do |req|
      req.url "#{username}/#{repo}/contents/#{file}?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}"
      req.headers['Content-Type'] = "application/vnd.github.v3+json"
      req.headers['User-Agent'] = ENV['GITHUB_USER_AGENT']
      req.headers['encoding'] = "utf-8"
    end

    raw_comparison_content = JSON.parse(comparison_response.body, object_class: OpenStruct).content
    Base64.decode64(raw_comparison_content) unless raw_comparison_content.nil?
  end
end


App.new.run
