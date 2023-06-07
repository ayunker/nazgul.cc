require "sinatra"
require "sequel"

get "/" do
  conn = Sequel.connect("postgresql://localhost/nazgul")
  total_distance = conn[:activities].where { activity_date > "2023-01-01" }.map(:distance).reduce(:+).to_f
  erb :index, locals: {total_distance:}
end
