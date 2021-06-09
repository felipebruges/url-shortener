class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :short_urls
end
