module Game
  class Game
    attr_reader :winner, :loser, :win_score, :lose_score

    def initialize(game_hash)
      @winner = game_hash['winner']
      @loser = game_hash['loser']
      @win_score = game_hash['winner score']
      @lose_score = game_hash['loser score']
    end

    def to_s
      @winner + ' beat ' + @loser + ' by a score of ' + @win_score.to_s + '-' + @lose_score.to_s
    end
  end
end