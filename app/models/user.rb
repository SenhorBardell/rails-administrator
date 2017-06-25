class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_and_belongs_to_many :roles

  after_create :attach_role

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, on: create

  scope :short, -> {select %w(id first_name last_name)}

  def is_admin?
    self.roles.exists? 1 # admin
  end

  def generate_token
    self.update_attribute(:token, self.class.generate_unique_secure_token)
  end

  def attach_role
    self.roles.push Role.find 2 # user, or find_by_name 'client'
  end

  def as_json(options={})
    options[:except] ||= [:password_digest, :token, :updated_at, :created_at]
    super(options)
  end

end
