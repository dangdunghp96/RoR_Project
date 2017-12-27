class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 8}, allow_nil: true
  validate :check_password

  has_secure_password

  has_many :orders

  def check_password
    if password
      password.each_char do |c|
        if !((c >= "a" && c <= "z") || (c >= "0" && c <= "9"))
          errors.add :password, "Password only have a-z and 0-9"
          break
        end
      end
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end

    def from_omniauth auth_hash
      user = find_or_create_by uid: auth_hash["uid"], provider: auth_hash["provider"]
      user.email = auth_hash["info"]["email"]
      user.name = auth_hash["info"]["name"]
      user.password = "12345678"
      user.save!
      user
    end
  end
end
