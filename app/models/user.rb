require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt

  before_save {self.email.downcase!}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :username, :email, :password, presence: true
  validates :username, length:  { maximum: 25 }
  validates :email, length:     { maximum: 50 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
  user = User.find_by(email: email)
    if user && user.password == password
       user
   else
      nil
   end
  end
end
