class PointGroup < ApplicationRecord
  has_many :evenements, dependent: :destroy

end
