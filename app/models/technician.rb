class Technician < ApplicationRecord
  has_many :installations, dependent: :destroy
  validates :name, presence: true
end