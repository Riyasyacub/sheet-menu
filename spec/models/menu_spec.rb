require "rails_helper"

RSpec.describe Menu, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:menu_items).dependent(:destroy) }
  it { should validate_presence_of(:sheet_key) }
  it { should validate_presence_of(:title) }
end
