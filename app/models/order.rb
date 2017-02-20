class Order < ActiveRecord::Base

  include Statesman::Adapters::ActiveRecordQueries   # Dodaktowo zimplementujemy taki modół - umozliwiajacy przeprowadzanie kwerend na zamowieniu np; pokaz wszsytkie zamowienia ktore sa przyjete do realizacji

  belongs_to :shipping_type
  has_many :line_items       # przedewszystkim musimy dodac fakt ze musimy miec wiele pozycji
  has_one :address           # datkowow zamowienie bedzie mialo jeden adres


  accepts_nested_attributes_for :address      # czyli deklarujemy ze akceptujemy zagnieżdzone atrybuty dla tej asocjacji
                                              # i od tego momentu gdy na klasie Order wywołamy metode np update_attributes
                                              # to atrybuty z adresem takze beda przetwarzane
                                              # i odpowiednie rekordy zostaną zapisane do BD
                                              # Dodajemy to poniewaz pojawia sie pytanie
                                              # W jaki sposób dodac adres dostawy do zamówienia - przeciez to jest nowy obiekt
                                              # Okazuje sie ze RAILSY dodaly mozliwosc edycji wielu obiektów naraz w jednym formularzu




  has_many :transitions, class_name: "OrderTransition", autosave: false   # Na podstawie tej asocjacji STATESMAN bedzie obliczal w jakim aktualnie statusie jest zamowienie

  # Kolejna wazna rzecza jest delegacja
  # Dziala to m.wiecej tak
  # - jezeli bedziemy miec w kontrolerze jakies konkretne zamowienie @order i bedziemy chcieli przejsc do innego stanu to
  # - to zamist pisac cos takiego   @order.state_machine.transaction_to :confirmed
  # - to my napiszemy tak           @order.transition_to :confirmed
  # Czyli metoda delegate opisuje nazwy metod ktorych wywolanie bedzie oddegelowane do pozadanego obiektu
  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine

  # Druga rzecza jest zdefiniowanie metody state_machine dzieki ktorej bedziemy w stanie odwolac sie
  # - z poziomu zamowienia do naszej maszyny stanow opisujacej stan konkretnego zamowienia
  # I w tej metodzie tworzymy instancje klasy OrderStateMachine, czyli tej klasy ktora wczesniej zdefinowalismy
  #   - i odpowiednio ja konfigurujemy
  def state_machine
    @state_machine ||= OrderStateMachine.new(self, transition_class: OrderTransition, association_name: :transitions)
  end


  # Metoda zwaracajaca sume calego zamowienia
  # Na sume calego zamówienia skladaja sie dwie rzeczy:
  #  - po pierwsze suma wszystkich pozycji w zamowieniu
  #  - po drugie suma kosztow dostawy
  def full_cost
    line_items.map { |e| e.full_price }.sum + shipping_cost           # Najpierw sumujemy wszystkie pozycjie a nastepnie dodajmey koszt dostway
  end


  # Na koniec dodamy trzy metody ktore konfirguruja STATESMANA
  # Potrzebuje on informacji tj.
  def self.transition_class            # - klasy przechowujacej przejscie
    OrderTransition
  end

  def self.initial_state               # - domyslny stan
    OrderStateMachine.initial_state
  end

  def self.transition_name             # - nazwy asocjacji przychowujacej wszystkie przjescia
    :transitions
  end


  
end
