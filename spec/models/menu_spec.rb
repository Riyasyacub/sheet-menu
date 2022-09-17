require "rails_helper"

RSpec.describe Menu, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:sheet_key)}
end