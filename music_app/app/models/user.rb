# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string
#

class User < ApplicationRecord
  validates :email, :password_digest, :session_token ,presence: true ,uniqueness: true
  validates :name , presence: true
  validates :password, length: { minimum: 6 , allow_nil: true}

  attr_reader :password



  after_initialize :ensure_session_token





   def self.find_by_credential(email, password)
     user= User.find_by(email: email)
     user && user.is_password?(password) ? user : nil
   end



  def generate_session_token
    token= SecureRandom.urlsafe_base64(16)
    generate_session_token if self.class.exists?(session_token: token)

  end

  def reset_session_token
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token

  end

  def password=(pass)
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end












end
