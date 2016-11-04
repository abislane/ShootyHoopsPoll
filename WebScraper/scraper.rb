require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open('http://www.sports-reference.com/cbb/boxscores/index.cgi?month=04&day=2&year=2016'))

games = []

doc.search('table.teams').each do |game|
  res = {}
  res['winner'] = game.search('tr.winner').search('a')[0].content
  res['winner score'] = game.search('tr.winner').search('td.right')[0].content.to_i
  res['loser'] = game.search('tr.loser').search('a')[0].content
  res['loser score'] = game.search('tr.loser').search('td.right')[0].content.to_i

  games.push(res)
end

puts games