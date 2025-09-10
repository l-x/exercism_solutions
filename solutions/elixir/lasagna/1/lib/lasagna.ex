defmodule Lasagna do
  @minutes_per_layer 2
  @expected_minutes_in_oven 40

  def expected_minutes_in_oven(), do: @expected_minutes_in_oven


  def remaining_minutes_in_oven(current_time_in_oven) do
    expected_minutes_in_oven() - current_time_in_oven
  end

  def preparation_time_in_minutes(layers) do
    layers * @minutes_per_layer
  end

  def total_time_in_minutes(layers, current_time_in_oven) do
    preparation_time_in_minutes(layers) + current_time_in_oven
  end

  def alarm(), do: "Ding!"
end
