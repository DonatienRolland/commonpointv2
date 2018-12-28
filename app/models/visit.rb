class Visit < ApplicationRecord

  scope :at, -> (date) { where(created_at: date) }
  scope :from_to, -> (start_date, end_date) { where('created_at >= ? AND created_at <= ?', start_date, end_date) }

  def group_by_criteria
    created_at.to_date.to_s(:db)
  end
end


