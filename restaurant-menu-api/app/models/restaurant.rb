class Restaurant < ApplicationRecord
  include NormalizableName
  
  has_many :menus, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
