class User < ActiveRecord::Base
  before_save :create_avatar_url

  attr_accessible :avatar_url, :email, :name, :password, :password_confirmation, :username
  has_secure_password
  before_validation :prep_email
  validates :name, presence: true
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: /^[\w.+-]+@([\w]+.)+\w+$/ }

  has_many :ribbits
  has_many :follower_relationships, classname: "Relationship", foreing_key: "followed_id"
  has_many :followed_relationships, classname: "Relationship", foreing_key: "follower_id"

  def following? user
    self.followeds.include? user
  end

  def follow user
    Relationship.create follower_id: self.id, followed_id: user.id
  end
  
  private

  def prep_email
  	self.email = self.email.strip.downcase if self.email
  end

  def create_avatar_url
  	self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
  end

end
