class Category < ActiveRecord::Base
  has_many :products

  validates :name, presence: true      # zrobmy odrazu walidacje na to pole

end
