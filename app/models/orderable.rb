class Orderable < ApplicationRecord
  belongs_to :menu_item
  belongs_to :cart

  def total
    menu_item.price * qty
  end

  def tax
    total * 0.05
  end
end
