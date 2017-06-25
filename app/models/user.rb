class User < ApplicationRecord
  has_secure_password
  has_secure_token
  has_and_belongs_to_many :roles
  before_create :generate_token
  after_create :attach_role

  validates :email, uniqueness: true
  validates :password, presence: true, on: create

  def is_admin?
    self.roles.exists? 1 # admin
  end

  def generate_token
    self.token = SecureToken.generate_unique_secure_token unless token.present?
  end

  def attach_role
    self.roles.push Role.find 2 # user, or find_by_name 'client'
  end

  def as_json(options={})
    options[:except] ||= [:password_digest, :token, :updated_at, :created_at]
    super(options)
  end

end
