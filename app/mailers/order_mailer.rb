class OrderMailer < ApplicationMailer

  # i kazda z tych metod przyjmuje argument order
  # i docelowo bedzie wysiwetlona w tresci maila
  def order_confirmation(order)
    @order = order

    mail to: order.address.email, subject: "Dziękujemy za zamówienie"  # Oczywiscie mail wysylamy do podanego maila, oraz wysylamy wiadomosc o odpowiedniej tresci
  end

  def order_in_progress(order)
    @order = order

    mail to: order.address.email, subject: "Zamówienie w realizacji"
  end

  def order_shipped(order)
    @order = order

    mail to: order.address.email, subject: "Zamówienie wysłane"
  end

  def order_cancelled(order)
    @order = order

    mail to: order.address.email, subject: "Zamówienie anulowane"
  end
end
