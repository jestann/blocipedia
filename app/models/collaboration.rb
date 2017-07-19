class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  
  validates :wiki, presence: true
  validates :user, presence: true, uniqueness: { scope: :wiki, message: "already added this user to this wiki" }
end
