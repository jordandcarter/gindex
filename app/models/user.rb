class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :user_websites
  has_many :websites, :through => :user_websites
  
  def admin?
    admin_level == 1
  end
  
  def set_admin(value)
    self.admin_level = value ? 1 : 0
  end
end
