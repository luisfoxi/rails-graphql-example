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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :token_authenticatable

  has_many :posts
  has_many :comments
  has_many :replies
end
