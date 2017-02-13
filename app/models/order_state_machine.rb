class OrderStateMachine
  include Statesman::Machine

  # Definijemy nazw stanow
  state :new, initial: true      # Czyli zamowienie jest nowe, jest jeszcze koszykiem, nie zostalo zlozone
  state :confirmed               # Zostalo potwierdzone
  state :in_progress             # Zamówienie w trakcjie realizacji
  state :shipped                 # Zamówienie wyslane
  state :cancelled               # Zamowienie anulowane

  # Tutaj dodamy mozliwosci przejscia pomiedzy jednym stanem a drugim
  transition from: :new, to: [:confirmed, :cancelled]          # Czyli z koszyka mozemy przejsc z zamowienia potwierdzonego lub anulowanego
  transition from: :confirmed, to: [:in_progress, :cancelled]  # Z potweirdzonego mozemy przejsc do realizajci lub anulowanego
  transition from: :in_progress, to: [:shipped, :cancelled]    # Z realizacji mozemy przejsc do wyslanego lub anulowanego
  transition from: :shipped, to: [:cancelled]                  # Z wyslanego mozemy przejsc do anulowanego


  # Tutaj dodatkowo opiszemy co ma sie dziac gdy zamowienie przechodzi do stanu anulowanego
  after_transition(to: :cancelled) do |order, transition|
    OrderMailer.order_cancelled(order).deliver               # Oczywiescie bedziemy wysylac maila informujacego ze zamowienie zostalo anulowane
  end

  after_transition(to: :confirmed) do |order, transition|
    OrderMailer.order_confirmation(order).deliver            # Tu dziekujemy za zloznie zamowienia
  end

  after_transition(to: :in_progress) do |order, transition|
    OrderMailer.order_in_progress(order).deliver             # Tu zamowienia przyjete do realizacji
  end

  after_transition(to: :shipped) do |order, transition|
    OrderMailer.order_shipped(order).deliver                 # I tu inforamcaja ze zamowienie zostalo wyslane
  end


  # Tutaj mamy wlasna metode w ktorej nadajemy polski odpowiednik
  # - kazdemu ze stanu
  # - bedzie to nam sluzylo w panelu admina, aby wyswietlic  przyjazny dla administratora sklepu formularz, ktory pozowli na zmiane zamowienia
  def self.states_map
    {
        "new" => "Niepotwierdzone",
        "confirmed" => "Złożone przez klienta",
        "in_progress" => "Przyjęte do realizacji",
        "shipped" => "Wysłane",
        "cancelled" => "Anulowane",
    }
  end
end