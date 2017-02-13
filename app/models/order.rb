class Order < ActiveRecord::Base
  belongs_to :shipping_type
  has_many :line_items       # przedewszystkim musimy dodac fakt ze musimy miec wiele pozycji
  has_one :address           # datkowow zamowienie bedzie mialo jeden adres

  # Metoda zwaracajaca sume calego zamowienia
  # Na sume calego zamówienia skladaja sie dwie rzeczy:
  #  - po pierwsze suma wszystkich pozycji w zamowieniu
  #  - po drugie suma kosztow dostawy
  def full_cost
    line_items.map { |e| e.full_price }.sum + shipping_cost           # Najpierw sumujemy wszystkie pozycjie a nastepnie dodajmey koszt dostway
  end


  
end
