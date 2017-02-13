# I ten kod bedzie wywolywany za kazdym razem
# - kiedy bedzie uruchamiana nasz aplikacja
# - czyli w momecie startu serwera, konsoli lub testow
Statesman.configure do
  storage_adapter(Statesman::Adapters::ActiveRecord)
end
