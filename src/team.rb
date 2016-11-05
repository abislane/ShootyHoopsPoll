module Team
  class Team
    attr_reader :name, :num_games, :num_wins, :score, :rank
    attr_writer :name, :num_games, :num_wins, :score, :rank

    def initialize(name)
      @name = name
      @num_games = 0
      @num_wins = 0
      @score = 0
      @rank = 1
    end

    def add_game(won, points, opp_rank)
      @num_games += 1
      if(won)
        @games_won += 1
      end
    end

    def to_s
      @name + " has won " + @num_wins.to_s + " out of " + @num_games.to_s + " games"
    end
  end
end