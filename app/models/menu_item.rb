class MenuItem < ApplicationRecord
  belongs_to :menu
  has_many :orderables
  has_many :carts, through: :orderabes
  validates_presence_of :category, :item_name, :price
end
