class Activity < ApplicationRecord
  # TODO: we'll extract this
  GEAR = {
    "b12365531" => "yanyon",
    "b3024328" => "rush hour"
  }

  scope :by_year, ->(year) {
    where(activity_date: Date.new(year).beginning_of_year..Date.new(year).end_of_year)
  }

  scope :with_kat, -> { where(with_kat: true) }
  scope :on_bike, -> { where.not(bike: nil) }
end
