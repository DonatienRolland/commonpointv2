class Evenement < ApplicationRecord
  belongs_to :user

  belongs_to :user_activity, required: false
  accepts_nested_attributes_for :user_activity, :reject_if => :all_blank
  accepts_nested_attributes_for :user, :reject_if => :all_blank

  belongs_to :point_group, required: false

  has_one :activity, through: :user_activity

  has_one :company, through: :user

  has_many :materiels, dependent: :destroy
  accepts_nested_attributes_for :materiels, reject_if: :all_blank, allow_destroy: true

  has_many :participants, dependent: :destroy
  # has_many :users, through: :participant # Attention si on accepte c'est relation, cela impact company.evenements
  accepts_nested_attributes_for :participants, reject_if: :all_blank, allow_destroy: true

  enum type_of_evenement: {
    "Privé" => 0,
    Publique: 1
  }
  # scope :invited, -> (user) { joins(:participant).merge(Participant.where(user: user)) }

  has_many :messages, dependent: :destroy

  scope :activity_title, -> (current_title) { joins(:user_activity).merge(UserActivity.by_activity_title(current_title)) }
  scope :from_to, -> (start_date, end_date) { where('jour >= ? AND jour <= ?', start_date, end_date) }
  scope :a_venir, -> { where('jour >= ?', DateTime.now) }
  scope :boosted, -> { where( boosted: true ) }

  validates :user, :user_activity, :type_of_evenement, presence: true
  # validates :jour, presence: true, if: :second_step

  geocoded_by :adresse
  after_validation :geocode, if: :will_save_change_to_adresse?

  before_save :set_group_of_point

  def second_step
    self.id.nil? ? false : true
  end

  def start_time
    self.jour ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end

  def is_new?
    if self.created_at > Date.today - 1.hours
      true
    end
  end

  def set_group_of_point
    if self.point_group_id.nil?
      group = PointGroup.create!
      self.point_group_id = group.id
      self.save
    end
  end

  def generate_participant(user, participation_status)
    participant = Participant.where(user: user, evenement: self).first
    if  !participant.present?
      Participant.create!(user: user, evenement: self, participe: participation_status)
    end
  end

  def check_if_full
    if self.nombre_max <= self.participants.where(participe: true).count
      self.full = true
    else
      self.full = false
    end
    self.save
  end

  def delete_participant(user)
    participant = Participant.where(user: user, evenement: self).first
    orga = self.user
    if participant.present? && user != orga
      participant.destroy
    end
  end

  def activity_title
    self.activity.title
  end

  def day_month_hour
    return "#{self.date_day} à #{ self.date_hour}"
  end
  def date_day
    if !self.jour.nil?
      self.jour.strftime("%A %d %B %Y")
    end
  end
  def date_hour
    if !self.heur.nil?
      self.heur.strftime("%H:%M")
    end
  end
end
