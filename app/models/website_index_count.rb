class WebsiteIndexCount < ActiveRecord::Base

  belongs_to :website
  
  named_scope :from_date, lambda { |date| {:conditions => ["website_index_counts.created_at >= ?", date] } }
  named_scope :to_date, lambda { |date| {:conditions => ["website_index_counts.created_at <= ?", date] } }
  
end
