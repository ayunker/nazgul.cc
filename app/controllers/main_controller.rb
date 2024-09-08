class MainController < ApplicationController
  def index
    @total_distance = Activity
      .by_year(2024)
      .on_bike
      .with_kat
      .sum(&:distance).to_f
  end
end
