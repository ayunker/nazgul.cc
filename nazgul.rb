require "sinatra"
require "sequel"

get "/" do
  total_distance = 0
  Sequel.connect("postgresql://localhost/nazgul") do |conn|
    total_distance = conn[:activities].where { activity_date > "2023-01-01" }.map(:distance).reduce(:+).to_f
  end
  erb :index, locals: {total_distance:}
end
