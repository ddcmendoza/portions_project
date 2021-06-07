FactoryBot.define do
  factory :user do
    password { '123456' }
    email { 'test@gmail.com' }
  end
end
