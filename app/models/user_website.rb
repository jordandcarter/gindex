class UserWebsite < ActiveRecord::Base

  belongs_to :website
  belongs_to :user  
  
end
