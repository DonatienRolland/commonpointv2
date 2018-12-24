class Message < ApplicationRecord
  belongs_to :evenement
  belongs_to :participant
  validates :content, presence: true
end
