class User < ApplicationRecord
  has_secure_password
  has_secure_token
  before_create :generate_token

  # TODO validation

  def generate_token
    self.token = SecureToken.generate_unique_secure_token unless token.present?
  end

  def as_json(options={})
    options[:except] ||= [:password_digest, :token, :updated_at, :created_at]
    super(options)
  end

end
