class OrderTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition


  belongs_to :order, inverse_of: :transitions
  #i zmienimy tu jedna rzecz:
  # Widzimy ze jest napisane order_transitions ale my zmienimy na transitions
  #       zmieniamy z :   belongs_to :order, inverse_of: :order_transitions
  #                 na:   belongs_to :order, inverse_of: :transitions
  #
  # ^ inverse_of - ogolnie opisuje nazwe stansakcji ktora jest w druga strone
  #   - wiec jezeli zamowienie bedzie mialo wiele transitions, czyli przejsc
  #     pomiedzy jednym stanem a drugim
  #     to pojedyncze transitions oczywiscie bedzie nalezalo do zamoienia
  #     ale bedzie tez opisywalo ze chodzi o odwrotna strone asocjacji transitions


end
