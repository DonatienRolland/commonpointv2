class UserActivity < ApplicationRecord

  belongs_to :activity
  belongs_to :user

  validates :level, presence: true

  has_many :evenements, dependent: :destroy
  accepts_nested_attributes_for :evenements, reject_if: :all_blank

  scope :by_activity_title, -> (current_title) { joins(:activity).merge(Activity.by_title(current_title)) }
  # scope :titles {  joins(:activity).merge(Activity.title) }
end

