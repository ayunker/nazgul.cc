class StravaClient
  def activities
    acc = []
    client.athlete_activities(per_page: 30) do |activity|
      # next if existing_activities.include?(activity["id"])
      acc << hsh_from(activity:)
    end
    acc
  end

  def client
    @client ||= Strava::Api::Client.new(access_token:)
  end

  private

  def hsh_from(activity:)
    {
      strava_id: activity["id"],
      external_id: activity["external_id"],
      name: activity["name"],
      distance: (activity["distance"] * 0.000621371).round(2),
      moving_time: (activity["moving_time"].to_f / 60 / 60).round(2),
      elapsed_time: (activity["elapsed_time"].to_f / 60 / 60).round(2),
      activity_date: activity["start_date_local"].to_date.iso8601,
      bike: Activity::GEAR[activity["gear_id"]],
      average_speed: (activity["average_speed"] * 2.23694).round(2),
      max_speed: (activity["max_speed"] * 2.23694).round(2),
      average_watts: activity["average_watts"].to_f.round(2),
      with_kat: activity["name"].downcase.include?("w kat")
    }
  end

  def access_token
    return @access_token if defined?(@access_token)

    uri = URI("https://www.strava.com/oauth/token")
    result = Net::HTTP.post_form(uri,
      "client_id" => config[:client_id],
      "client_secret" => config[:client_secret],
      "refresh_token" => config[:refresh_token],
      "grant_type" => "refresh_token")

    @access_token = JSON.parse(result.body)["access_token"]
  end

  def config
    Rails.application.credentials.strava
  end
end
