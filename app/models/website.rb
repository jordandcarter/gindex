require "lib/counter"
class Website < ActiveRecord::Base

  has_many :user_websites
  has_many :users, :through => :user_websites
  has_many :counts, :class_name => "WebsiteIndexCount"
  
  named_scope :from_date, lambda { |date| {:conditions => ["websites.created_at >= ?", date] } }
  named_scope :to_date, lambda { |date| {:conditions => ["websites.created_at <= ?", date] } }
  
  def count
    c= WebsiteIndexCount.new(:count => Counter.grab(url).gsub(",","").to_i)
    counts << c
    puts "#{c.website.url}:#{c.count}" if RAILS_ENV=="development"
  end
  
  def self.count_all
    Website.all.each do |website|
      website.count
      delay = RAILS_ENV=="development" ? 5 : 30
      sleep delay+rand(delay)
    end
  end
  
end
