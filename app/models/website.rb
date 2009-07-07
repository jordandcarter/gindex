require "lib/counter"
class Website < ActiveRecord::Base

  has_many :user_websites
  has_many :users, :through => :user_websites
  has_many :counts, :class_name => "WebsiteIndexCount"
  
  named_scope :from_date, lambda { |date| {:conditions => ["websites.created_at >= ?", date] } }
  named_scope :to_date, lambda { |date| {:conditions => ["websites.created_at <= ?", date] } }
  
  def count
    counts << WebsiteIndexCount.new(:count => Counter.grab(url).gsub(",","").to_i)
  end
  
  def self.count_all
    Website.all.each do |website|
      website.count
      sleep 30+rand(30)
    end
  end
  
end
