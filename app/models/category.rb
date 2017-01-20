class Category < ActiveRecord::Base
  has_many :prodcuts

  validates :name, presence: true      # zrobmy odrazu walidacje na to pole

end
