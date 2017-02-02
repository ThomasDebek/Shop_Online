class Admin::BaseController < ApplicationController
  layout 'admin'                  # Wybieram layouts
  before_action :authenticate     # Uwiezytelniam uzytkownika, czyli nikt nie ma wstepu do panelu admina, chyba ze zna login i haslo

  def authenticate                # I tu jest nasze uwiezytelnienie uzytkownikow
    authenticate_or_request_with_http_basic 'Podaj hasło!' do |name, password|
      name == 'username' && password == 'secret'
    end
  end

end





