require "dotenv"
require "strava-ruby-client"
require "sequel"

Dotenv.load

GEAR = {
  "b12365531" => "yanyon",
  "b3024328" => "rush hour"
}

uri = URI("https://www.strava.com/oauth/token")
result = Net::HTTP.post_form(uri,
  "client_id" => ENV["CLIENT_ID"],
  "client_secret" => ENV["CLIENT_SECRET"],
  "refresh_token" => ENV["REFRESH_TOKEN"],
  "grant_type" => "refresh_token")

access_token = JSON.parse(result.body)["access_token"]

client = Strava::Api::Client.new(access_token:)

def hsh_from(activity:)
  {
    strava_id: activity["id"],
    external_id: activity["external_id"],
    name: activity["name"],
    distance: (activity["distance"] * 0.000621371).round(2),
    moving_time: (activity["moving_time"].to_f / 60 / 60).round(2),
    elapsed_time: (activity["elapsed_time"].to_f / 60 / 60).round(2),
    activity_date: activity["start_date_local"].to_date.iso8601,
    bike: GEAR[activity["gear_id"]],
    average_speed: (activity["average_speed"] * 2.23694).round(2),
    max_speed: (activity["max_speed"] * 2.23694).round(2),
    average_watts: activity["average_watts"].to_f.round(2),
    with_kat: activity["name"].downcase.include?("w kat"),
    created_at: Time.now,
    updated_at: Time.now
  }
end

conn = Sequel.connect(ENV["DATABASE_URL"])
existing_activities = conn[:activities].map(:strava_id)

client.athlete_activities(per_page: 30) do |activity|
  next if existing_activities.include?(activity["id"])
  conn[:activities].insert(hsh_from(activity:))
end
