# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  
  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length { minimum: 6 }, allow_nil: true
  
  has_many :cats,
    foreign_key: :owner_id,
    class_name: :Cat
  
  has_many :cat_rental_requests
  
  def self.find_by_credentials(username, password)
    use = User.find_by(username: username)
    return nil if user.nil?
    return nil unless user.is_password?
  end 
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end
  
  def is_password?(password)
    bcrypt_password = BCrypt::Password.new(self.password_digest)
    bcrypt_password.is_password?(password)
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def reset_session_token!
    self.update!(session_token: self.class.generate_session_token)
    self.session_token
  end
  
  
  
  
end
