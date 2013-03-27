class Relationship < ActiveRecord::Base
  attr_accessible :followed_id, :follower_id

  belongs_to :follower, class "User"
  belongs_to :followed, class "User"

end
