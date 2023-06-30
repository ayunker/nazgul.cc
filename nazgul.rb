require "sinatra"
require "sequel"
require "dotenv"

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
