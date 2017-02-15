class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_cart

  def current_cart                     # Ta metoda bedzie zwracala aktualny koszyk
    if session[:order_id]              # Nr. koszyka czyli jego id bedzie przechowywane w sesii
      Order.find(session[:order_id])   # i w momencie kiedy w przeglądarce użytkownika zapisany jest jakis koszyk, to zostanie odnalieziony w BD i zwrócony
    else
      Order.new                        # W przeciwnym razie kiedy w sesii nie ma zadenego koszyka - to zwracamy swiezy obiekt nie zapisany w BD
    end
  end


  def current_cart_or_create           # metoda tworzaca koszyk
    c = current_cart                   # pobieramy koszyk
    if c.new_record?                   # jezeli koszyka jest nowym rekorderm
      c.save                           # to zapisujemy go w BD
      session[:order_id] = c.id        # Nastepnie zapamietujemy jego nr id w sesji
    end
    c                                  # i tutaj zwracamy koszyk
  end

                                       # i od teraz nasz current_cart bedzie zwracal nam zamowienie ktore stworzylismy i zapisalismy do BD





end
