FactoryBot.define do
  factory :reply do
   body { Faker::Lorem.sentence }
   comment
   user
  end
end
