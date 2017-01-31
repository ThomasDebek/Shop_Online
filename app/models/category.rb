class Category < ActiveRecord::Base
  has_many :products

  validates :name, presence: true      # zrobmy odrazu walidacje na to pole




  def to_param
    "#{id}-#{name}".parameterize
  end

  # dziki tej metodzie (patrz wyzej), bedziemy mogli wyswietlac nazwe danego produktu w pasku
  # czyli zamiast products/id
  # to products/nazwa_produktu
  # domyslnie railsy zwarcaja id
  # a w momecie te metode zformulujemy (pracujemy na modelu, path )


end
