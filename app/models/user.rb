class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :prenom, :nom, presence: true

  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_FORMAT }, uniqueness: true

  before_validation(on: :create) do
    self.format_user_infos
    self.link_to_the_company
  end

  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities
  # accepts_nested_attributes_for :user_activities, allow_destroy: true, reject_if: :all_blank
  # accepts_nested_attributes_for :activities, allow_destroy: true, reject_if: :all_blank

  belongs_to :company
  accepts_nested_attributes_for :company, :reject_if => :all_blank

  mount_uploader :avatar, PhotoUploader

  def his_avatar
    init1 = self.prenom.split(//).first
    init2 = self.nom.split(//).first
    init = init1 + init2
  end

  def format_user_infos
    self.prenom.capitalize!
    self.nom.capitalize!
  end

  def match_with_a_company?
    user_domain = self.email.split("@").second
    if Company.where(email_domain: user_domain ).count > 0
      return true
    end
  end

  def link_to_the_company
    if self.company.nil?
      user_domain = self.email.split("@").second
      comp = Company.where(email_domain: user_domain).first
      self.company = comp
    end
  end
end
