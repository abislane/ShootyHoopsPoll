require 'open-uri'
require 'nokogiri'
require 'date'

module Scraper
  class GameScraper
    def self.get_games(day)
      puts 'processing day '+day.to_s
      path = 'http://www.sports-reference.com/cbb/boxscores/index.cgi?month='+day.mon.to_s+'&day='+day.day.to_s+'&year='+day.year.to_s
      parse_games(path)
    end

    def self.get_all_games(start_day, end_day)
      res = []
      start_day.upto(end_day) do |date|
        res += get_games(date)
      end
      res
    end

    def self.parse_games(path)
      doc = Nokogiri::HTML(open(path))
      #puts doc
      games = []

      doc.search('table.teams').each do |game|
        res = {}
        res['winner'] = game.search('tr.winner').search('a')[0].content
        res['winner score'] = game.search('tr.winner').search('td.right')[0].content.to_i
        res['loser'] = game.search('tr.loser').search('a')[0].content
        res['loser score'] = game.search('tr.loser').search('td.right')[0].content.to_i

        games.push(res)
      end

      #puts games
      games
    end
  end
end

include Scraper

puts GameScraper.get_games(Date.new(2016, 4, 2))

mm = GameScraper.get_all_games(Date.new(2016, 3, 15), Date.new(2016, 4, 4))
puts "processed"
mm.each do |game|
  puts game
end