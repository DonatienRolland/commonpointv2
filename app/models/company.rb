class Company < ApplicationRecord

  validates :nom, presence: true
  validates :email_domain, presence: true, uniqueness: true

  # has_many :users, dependent: :destroy
  has_many :users
  has_many :evenements, :through => :users
  has_many :activities, through: :users
  mount_uploader :icon, PhotoUploader

end

