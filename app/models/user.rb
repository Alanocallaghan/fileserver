class User < ApplicationRecord
  has_many :reports
  
  before_save { email.downcase! }
  validates :username,  presence: true, length: { maximum: 50 }
  validates :email, 
    presence: true, 
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }
  after_create :generate_authentication_token!
  validates :password, length: { minimum: 15 }


  has_secure_password

  private
  # Generate a session token
  def generate_authentication_token!
    self.authentication_token = Digest::SHA1.hexdigest("#{Time.now}-#{self.id}-#{self.updated_at}")
    self.save
  end
end

