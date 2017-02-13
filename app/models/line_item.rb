class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  def full_price
    unit_price * quantity
  end

end
