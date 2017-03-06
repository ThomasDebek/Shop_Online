class Admin::OrdersController < Admin::BaseController       # Musimy zmienic klase bazowa - dzieki czemu zabezpieczamy sie haslem
  def index
    @orders = Order.not_in_state(:new).page(params[:page]).per(20)   # uzyjemy metody od Statesmana -  i wymieniamy w ktorych stanach me tej metody nie byc, nie chcemy jej wylacznie w stanie new, i oczywiscie paginacja, i chce miec 20 zamowien na kazdej stronie
  end

  def show
    @order = Order.find(params[:id])   # akcja show - jest ona dosc trywialna, po prostu znajdujemy zamówienie po id
  end

  def update
    @order = Order.find(params[:id])     # znajdujemy zamowienie
    @order.transition_to params[:state]  # pobieramy stan z paramsow i próbujemy przejsc w ten stan ktory jest w paramsach
    redirect_to admin_order_path(@order), notice: "Pomyślnie zmieniono zamówienie."  # i jak udalo nam sie zmienic ten stan wracamy do szczegołow zamówienia
  end

end
