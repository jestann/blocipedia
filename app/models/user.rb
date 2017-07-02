class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :wikis
  
  enum role: [:standard, :premium, :admin]
  after_initialize { self.role ||= :standard }
         
  protected
  def confirmation_required?
    false
  end
end
