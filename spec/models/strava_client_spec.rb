require "rails_helper"

RSpec.describe StravaClient do
  describe "#activities" do
    let(:client) { double(Strava::Api::Client) }

    let(:output) do
      JSON.parse(File.read("spec/fixtures/strava_activity.json"))
    end

    let(:expected) do
      {strava_id: 12298254539,
       external_id: "992E05C8-6F1A-472A-BFDF-DDE8D051864C-activity.fit",
       name: "Metric Run w Kat",
       distance: 7.15,
       moving_time: 0.67,
       elapsed_time: 1.36,
       activity_date: "2024-09-01",
       bike: "yanyon",
       average_speed: 10.63,
       max_speed: 23.17,
       average_watts: 175.3,
       with_kat: true}
    end

    subject { described_class.new }

    before do
      allow(subject).to receive(:client).and_return(client)
      allow(client).to receive(:athlete_activities).and_yield(output)
    end

    it "parses the activities" do
      expect(subject.activities).to match([expected])
    end
  end
end
