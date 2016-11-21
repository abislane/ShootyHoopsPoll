require_relative 'team.rb'
require_relative 'scraper.rb'

module Ranking
  include Team

  def get_all_teams
    teams = {}

    cur_path = File.expand_path(File.dirname(__FILE__))
    team_path = File.join(cur_path, '../Confrences')

    Dir.foreach(team_path) do |conf|
      next if conf == '.' || conf == '..'
      more = get_teams_conf(File.open(team_path + '/' + conf))
      teams = teams.merge(more)
    end

    teams
  end

  def get_teams_conf(conf_file)
    teams = {}
    conf_file.each_line do |team|
      tmp = team.chomp
      teams[tmp] = Team.new(tmp)
    end
    teams
  end
end

include Ranking
include Scraper

ranks = Ranking::get_all_teams

ranks.each do |name, team|
  puts team.to_s
end

start_date = Date.new(2016, 11, 11)
end_date = Date.today.prev_day
games = GameScraper.get_all_games(start_date, end_date)
puts games