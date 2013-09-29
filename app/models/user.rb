class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registerable, :recoverable, :rememberable, :confirmable,
  # :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :trackable, :validatable,
         :token_authenticatable

  # audit for changes
  has_paper_trail
end
