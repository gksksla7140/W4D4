# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  name            :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates :name , presence: true
  validates :password , length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  has_many :requests,
  foreign_key: :user_id,
  class_name: :CatRequest


  attr_reader :password

  def self.find_by_credential(email,pass)
    user = User.find_by(email: email)
    return nil if user.nil?
    user.is_password?(pass) ? user : nil
  end

  def password= (pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)

  end

  def ensure_session_token
    self.session_token ||= uniq_session_token
  end

  def uniq_session_token
    token= SecureRandom.urlsafe_base64(16)
    uniq_session_token if self.class.exists?(session_token: token)
    token
  end

  def reset_session_token
    self.session_token = uniq_session_token
    self.save!
    self.session_token

  end




end
