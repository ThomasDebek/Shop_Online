class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])                        # i w akcji show powininsmy znalesc kategorie ktora chcemy wysietlac
    @products = @category.products.page(params[:page]).per(6)     # a po drugie znalezc produkty z tej kategorii i dodamy paginacje, na kazdej stronie 6produktow
  end
end
