class Order < ActiveRecord::Base
  belongs_to :shipping_type
end
