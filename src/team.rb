module Team
  class Team
    include Comparable
    attr_reader :name, :num_games, :num_wins, :score, :rank
    attr_writer :name, :num_games, :num_wins, :score, :rank

    def initialize(name)
      @name = name
      @num_games = 0
      @num_wins = 0
      @score = 0
      @rank = 1
    end

    def <=>(other)
      return @score / @num_games <=> other.score / other.num_games
    end

    def add_game(won, points, opp_rank)
      @num_games += 1
      if(won)
        @num_wins += 1
      end

      @score += points 
    end

    def to_s
      @name + " has won " + @num_wins.to_s + " out of " + @num_games.to_s + " games"
    end
  end
end