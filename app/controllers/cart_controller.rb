class CartController < ApplicationController
  def show
    @cart = current_cart
  end

  def edit
  end

  def confirmation
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


end
