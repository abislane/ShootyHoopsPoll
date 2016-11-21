require_relative 'team.rb'
require_relative 'scraper.rb'

module Ranking

  class Ranker
    include Team
    include Game
    include Scraper
    attr_reader :ranks, :teams, :games

    def initialize
      @teams = get_all_teams
      @games = get_all_games
      rank_teams
    end

    def rank_teams
      @games.each do |game|
        if @teams.key?(game.winner)
          teams[game.winner].num_wins += 1
          teams[game.winner].num_games += 1
        else
          #puts game.winner + ' not found'
        end

        if @teams.key?(game.loser)
          teams[game.loser].num_games += 1
        else
          #puts game.loser + ' not found'
        end
      end
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

    def get_all_games
      start_date = Date.new(2016, 11, 11)
      end_date = Date.today.prev_day
      games = GameScraper.get_all_games(start_date, end_date)
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
end

include Ranking

ranks = Ranker.new
ranks.teams.each_value do |record|
  puts record
end