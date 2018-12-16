class Activity < ApplicationRecord
  belongs_to :category

  has_many :user_activities, dependent: :destroy
  has_many :users, through: :user_activities

  # scope :with , -> (category_title) { where(category_id: Category.where(title: category_title).first.id ) }
  scope :are_activities_with, -> (user) { joins(:user_activities).merge(UserActivity.where(user: user)) }

  def is_an_activity_with(user)
    return UserActivity.where(user: user, activity: self).first
  end

end
