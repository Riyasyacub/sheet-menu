require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it { should belong_to(:menu) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:item_name) }
  it { should validate_presence_of(:price) }
end
