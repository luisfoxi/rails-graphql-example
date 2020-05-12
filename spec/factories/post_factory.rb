FactoryBot.define do
  factory :post do
   body { Faker::Lorem.sentence }
   title { Faker::Lorem.word }
   user
  end
end
