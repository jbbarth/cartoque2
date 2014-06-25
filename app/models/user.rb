class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registerable, :recoverable, :rememberable, :confirmable,
  # :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :trackable, :validatable

  # audit for changes
  # ignore attributes that are updated on each request by devise..
  has_paper_trail ignore: %i(last_sign_in_at current_sign_in_at sign_in_count updated_at)

  def seen_on
    time = [self.last_sign_in_at, self.current_sign_in_at].compact.max
    time.nil? ? "" : time.to_date
  end
end
