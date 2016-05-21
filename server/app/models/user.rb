class User < ActiveRecord::Base
  belongs_to :family
	has_many :showers
	before_create :set_auth_key
	has_secure_password
	private
  def set_auth_key
    return if auth_key.present?
    self.auth_key = generate_auth_key
  end
  def generate_auth_key
    SecureRandom.uuid.gsub(/\-/,'')
	end
end