class Surgery < ApplicationRecord
  has_many :doctor_surgeries
  has_many :doctors, through: :doctor_surgeries

  def self.find_others_by_day(day)
    where(day_of_week: day)
  end
end
