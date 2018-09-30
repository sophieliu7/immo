class Search < ApplicationRecord

  validates :min_budget, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :max_budget, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :min_living_space, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :max_living_space, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :min_land_area, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :max_land_area, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  # validates :rooms, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  # validates :bedrooms, :allow_nil => true
  # validates :rooms, :allow_nil => true



end
