class Product < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true                        # pole z nazwa nie moze byc puste
  validates :description, presence: true                 # pole z opisem nie moze byc puste
  validates :price, numericality: { greater_than: 0.0 }  # cena powinna byc wieksza niz zero i musi byc liczba
  validates :category, presence: true                    # deklarujemy ze chcemy ja zwalidowac i przypozadkowac do kategorii


  mount_uploader :photo, ProductPhotoUploader
      # Musimy takze zamontowac nasz uploader pochodzacy z gemu CarrierWave
      # Jako argument przkazujemy nazwe photo, ktora bedzie przechowywala sciezke do pliku
      # Oraz nazwe klasy, ktora obsluguje dane uploadsy
end



