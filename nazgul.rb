require "dotenv"
require "json"
require "sinatra"
require "sequel"

Dotenv.load

get "/" do
  total_distance = 0
  Sequel.connect(ENV["DATABASE_URL"]) do |conn|
    total_distance = conn[:activities]
      .where { activity_date > "2023-01-01" }
      .where(with_kat: true)
      .map(:distance)
      .reduce(:+)
      .to_f
  end

  erb :index, locals: {total_distance:}
end

get "/api/activities" do
  activities = nil
  Sequel.connect(ENV["DATABASE_URL"]) do |conn|
    activities = conn[:activities]
      .where { activity_date > "2024-01-01" }
      .where(with_kat: true)
  end

  activities.map { |r| r }.to_json
end
