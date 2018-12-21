class Materiel < ApplicationRecord
  belongs_to :participant, required: false
  belongs_to :evenement

  validates :title, presence: true
  validates_associated :evenement

  accepts_nested_attributes_for :evenement, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :participant

end
