class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.not_in_state(:new).page(params[:page]).per(20)   # uzyjemy metody od Statesmana -  i wymieniamy w ktorych stanach me tej metody nie byc, nie chcemy jej wylacznie w stanie new, i oczywiscie paginacja, i chce miec 20 zamowien na kazdej stronie
  end

  def show
  end
end
