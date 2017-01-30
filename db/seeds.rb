# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




  8.times do                                                   # W tym bloku losujemy 8 kategori
    Category.create! name: Faker::Hacker.ingverb.capitalize    # Tu tworzymy nowe kategorie z losowa nazwa wygenerowana przez Fakera
  end

  category_ids = Category.pluck(:id)                           # Tutaj przechowuje w zmiennej wszystkie numery id tych kategorii,
                                                               # metoda pluck  w active record przyjmuje 1argument w postaci nazwy kolumny
                                                               # i ta metoda zwraca tablice z wartosciami w tej kolumnie wszystkich wierszy w bazie dannych

  print "Product "
  10.times do       # nastepnie 200 razy wywolujemy ten blok, i w nim dodajemy produkty
    product = Product.create! name: "#{Faker::Hacker.verb} #{Faker::Hacker.noun}".capitalize, # dajemy naze
                              description: Faker::Hacker.say_something_smart,                 # wywolujemy krotki opis
                              long_description: Faker::Lorem.paragraphs(3).join("\n\n"),      # Wywolujemy dlugi opis
                              category_id: category_ids.sample,                               # wybieramy losowa kategorie, czyli na tablicy z wszystkimi identyfikatorami kategorii wywolujemy metode sample, ktroy zwraca losowy element z tej tablicy
                              price: Faker::Number.decimal(3, 2)                              # generujemy losowa cene
    product.remote_photo_url = Faker::Avatar.image(product.name.parameterize, "640x480", "jpg", "set#{[1, 2, 3].sample}", "bg#{[1, 2].sample}")
    product.save   # zapisujemy produkt
    print "."      # kropecza sygnalizuje nam ze cos sie dzieje poniewaz skrytp bedzie dzialal dosc dlugo, ze sie nie zawiesil, nie zapetlil
  end
  puts             # i wyswitlamy




