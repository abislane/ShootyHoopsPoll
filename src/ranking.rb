require_relative 'team.rb'

module Ranking
  include Team
  class Ranker

  end

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

ranks = Ranking::get_all_teams

ranks.each do |name, team|
  puts team.to_s
end