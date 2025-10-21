class Menu < ApplicationRecord
  belongs_to :restaurant
  has_and_belongs_to_many :menu_items, dependent: :destroy

  validates :name, presence: true
end
