class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  scope :incoming,  -> { where('start_at > ?', Time.zone.now) }

  scope :day, -> { where(created_at: Time.zone.now.all_day) }
  scope :week, -> { where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :month, -> { where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day)}

end
