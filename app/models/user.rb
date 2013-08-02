class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registerable, :recoverable, :rememberable
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :trackable, :validatable
end
