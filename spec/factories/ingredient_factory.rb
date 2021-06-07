FactoryBot.define do
  factory :ingredient do
    name { 'test' }
    brand { 'test brand' }

    trait :brand2 do
      brand { 'test brand 2' }
    end
  end
end
