require 'json'

def create_genres_relationships(new_game, genres)
  return if genres == nil
  begin
    genres.each do |genre|
      new_game.genres << Genre.find_by(name: genre)
    end
  rescue
    p "Genre relationship not created for #{new_game}"
  end
end

def create_platforms_relationships(new_game, platforms)
  return if platforms == nil
  begin
    platforms.each do |platform|
      new_game.platforms << Platform.find_by(name: platform["name"])
    end
  rescue
    p "Platform relationship not created for #{new_game}"
  end
end

def create_involved_companies_relationships(new_game, involved_companies)
  return if involved_companies == nil
  begin
    involved_companies.each do |involved_company|
      company = Company.find_by(name: involved_company["name"])
      InvolvedCompany.create( company: company, 
                              game: new_game, 
                              developer: involved_company["developer"],
                              publisher: involved_company["publisher"] )
    end
  rescue
    p "Involved company relationship not created for #{new_game}"
  end
end

puts "Start seeding data"

companies_array = JSON.parse(File.read('db/companies.json'))
platforms_array = JSON.parse(File.read('db/platforms.json'))
genres_hash = JSON.parse(File.read('db/genres.json'))
games_array = JSON.parse(File.read('db/games.json'))

puts "Loading companies"
companies_array.each do |company|
  new_company = Company.new(company)
  p "#{company.to_s} not created" unless new_company.save
end

puts "Loading platforms"
platforms_array.each do |platform|
  new_platform = Platform.new(platform)
  p "#{platform.to_s} not created" unless new_platform.save
end

puts "Loading genres"
genres_hash["genres"].each do |genre|
  new_genre = Genre.new(name: genre)
  p "#{genre.to_s} not created" unless new_genre.save
end

puts "Loading main games and relations"

main_games = games_array.select do |game|
  game["parent"] == nil
end

main_games.each do |game|
  new_game = Game.new(  name: game["name"], 
                        summary: game["summary"], 
                        release_date: game["release_date"], 
                        category: game["category"], 
                        rating: game["rating"])
  if new_game.save
    create_genres_relationships(new_game, game["genres"])
    create_platforms_relationships(new_game, game["platforms"])
    create_involved_companies_relationships(new_game, game["involved_companies"])
  else
    p "#{new_game.to_s} not created"
  end
end

puts "Loading expansion games and relations"

expansion_games = games_array.select do |game|
  game["parent"] != nil
end

expansion_games.each do |game|
  parent = Game.find_by(name: game["parent"])

  new_game = Game.new(  name: game["name"], 
                        summary: game["summary"], 
                        release_date: game["release_date"], 
                        category: game["category"], 
                        rating: game["rating"],
                        parent_id: parent.id )
  if new_game.save
    create_genres_relationships(new_game, game["genres"])
    create_platforms_relationships(new_game, game["platforms"])
    create_involved_companies_relationships(new_game, game["involved_companies"])
  else
    p "#{new_game.to_s} not created"
  end
end

puts "End seeding data"