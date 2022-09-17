class Menu < ApplicationRecord
  belongs_to :user

  validates_presence_of :sheet_key
end
