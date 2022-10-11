FactoryBot.define do
  factory :orderable do
    menu_item { nil }
    cart { nil }
    qty { 1 }
  end
end
