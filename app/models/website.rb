class Website < ActiveRecord::Base

  has_many :user_websites
  has_many :users, :through => :user_websites
  has_many :counts, :class_name => "WebsiteIndexCount"
  
  def count
    counts << WebsiteIndexCount.new(:count => Counter.grab(url).gsub(",","").to_i)
  end
  
  def self.count_all
    Website.all.each do |website|
      website.count
      #sleep 60+rand(60)
    end
  end
  
end
