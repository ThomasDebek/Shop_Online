class CartController < ApplicationController
  def show
    @cart = current_cart
  end

  def edit
    @cart = current_cart                             # przypisujemy nasza zmienna do aktualnego koszyka
    @cart.build_address if @cart.address.blank?       # Wiec warunkowo bedziemy tutaj budowac pusty adres jesli tego adresu jeszcze nie ma w tym zamowieniu
                                                      # Czyli jesli adres jest pusty to wywolujemy metode build_address i ta metoda spowoduje dodanie do zamowienia nie zapisanego w BD pustego adresu
                                                     # i tutaj musimy upewnic sie ze do tego zamowienia dodany jest jakis adres
                                                     # chociazby mialby byc pusty i nie zapisany do BD
                                                     # do tego adresu dodamy również podformularz i ten adres musi istniec -  chociaz miałby byc pusty i niezapisany w BD
  end



  def update
    @cart = current_cart                                                 # standardowo ustawiamy aktulany koszyk
    if @cart.update_attributes(cart_attributes)                          # zdefinjujemy metode cart_attributess ktora dzieki za pomoca strong_params pobierze odpowiednie atrybuty z paramsow
      @cart.update_attribute(:shipping_cost, @cart.shipping_type.cost)   # - czyli pobieramy aktualny koszt jaki zostal wybrane przez tego uzytkowniaka. W momiecie kiedy uzytkownik wybieze sposob dostawy musimy zapamietac cene dostawy na wypadek gdyby jakis administarator zmienil cene
      redirect_to confirmation_cart_path                                 # jezeli uda sie zapisac te dane to przekierowujemy uzytkownika do akcji potwierdzenia zamowienia
    else
      render action: :edit                                               # w przeciwnym przypadku renderujemy akcje edit - czyli standart z kazdego cruda
    end
  end

  def confirmation
    @cart = current_cart                                                 # standardowo musimy ustawic na aktualny koszyk
  end


  def add_product
    order = current_cart_or_create                            # tworzymy i zapisujemy do BD
    product = Product.find(params[:product_id])               # znajdujemy produkt ktory chcemy dodac do koszyka
    if item = order.line_items.where(product: product).first  # i teraz kod ktoy sprawdza czy dany produkt jest juz w koszyku
      item.quantity += 1                                      # i jezeli jest to zwiekszamy o jeden
      item.save                                               # i zapisujemy
    else                                                          # Jezeli nie ma to tworzymy liczbe na fakturze
      order.line_items.create product: product,                   # Zapisujemy produkt
                              quantity: 1,                        # tworzymy liczbe
                              unit_price: product.price,          # zapisujemy aktualna cene produktu
                              item_name: product.name             # oraz nazwe produktu
    end
    redirect_to :back, notice: "Dodano produkt do koszyka"        # i po dodaniu koszyka, wracamy do poprzedniej strony z komunikatem ze dodano do koszyka
  end



  def remove_product                                          # Usówanie prodkutków z koszyka jest nieco prostsza
    order = current_cart                                      # szukamy aktualnego koszyka
    product = Product.find(params[:product_id])               # znajdujemy produkt z ktorego id jest podany w paramsach
    item = order.line_items.where(product: product).first     # szukamy pozycji w koszyku ktora odwoluje sie do znalezionego przez nas produktu
    if item                                                      # jezeli taka pozycja istnieje
      item.destroy                                               # to usówamy ja
    end
    redirect_to :back, notice: "Usunięto produkt z koszyka"      # po usunieciu wracamy na poprzednią strone
  end                                                            # Jezeli podamy BACK to zawsze wracamy na poprzednią strone - niezaleznie jaka ona jest



  private

  def cart_attributes                  # dodajmy metode potrzebna nam do metody edit (oczywiscie uzywamy metody strong_params aby bezpiecznie pobrac atrybuty naszego zamowienia)
    params.require(:order).permit(     # Czyli standardowo wymagam istnienia parametru Order i z tego parametru zezwalamy na atrubut
        :shipping_type_id,               # czyli identyfikator sposobu dostawy
        :comment,                        # komentarz
        :address_attributes => [       # Tutaj zasugerujemy, ze bedziemy miec zagniezdzone atrybuyty
            :first_name,
            :last_name,
            :city,
            :zip_code,
            :street,
            :email
        ]
    )
  end




end
