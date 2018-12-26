class Company < ApplicationRecord

  validates :nom, presence: true
  validates :email_domain, presence: true, uniqueness: true

  has_many :users, dependent: :destroy



  mount_uploader :icon, PhotoUploader

end

