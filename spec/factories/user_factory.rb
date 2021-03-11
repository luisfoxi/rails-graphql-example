# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  authentication_token            :text
#  authentication_token_created_at :datetime
#  email                           :string           default(""), not null
#  encrypted_password              :string           default(""), not null
#  first_name                      :string
#  last_name                       :string
#  remember_created_at             :datetime
#  reset_password_sent_at          :datetime
#  reset_password_token            :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name  { Faker::Name.first_name }
    last_name { Faker::Name.last_name}
    password { "123456" }
  end
end
