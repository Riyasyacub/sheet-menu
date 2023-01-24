class Table < ApplicationRecord
  has_many :carts
  belongs_to :menu

  # def current_cart
  #   recent_cart = carts.most_recently_created
  #   return if recent_cart.billed?
  #   recent_cart
  # end
end
