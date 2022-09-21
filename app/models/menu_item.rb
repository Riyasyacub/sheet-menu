class MenuItem < ApplicationRecord
  belongs_to :menu

  validates_presence_of :category, :item_name, :price
end
