class ActivityImporterJob < ApplicationJob
  def perform
    client = StravaClient.new
    activities = client.activities

    # TODO: theres for sure some clean up to do here
    existing_ids = Activity.pluck(:strava_id)
    activities.each do |a|
      next if existing_ids.include?(a[:strava_id])
      Activity.create!(a)
    end
  end
end
