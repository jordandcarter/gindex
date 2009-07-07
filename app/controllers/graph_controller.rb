class GraphController < ApplicationController
  
  def websites
    @end_date = Date.today
    @start_date = @end_date - 30
    
    @websites = current_user.websites
    @min = WebsiteIndexCount.from_date(@start_date).to_date(@end_date).minimum('count', :joins => {:website => :user_websites}, :conditions => ["user_id = ?",current_user.id])
    @max = WebsiteIndexCount.from_date(@start_date).to_date(@end_date).maximum('count', :joins => {:website => :user_websites}, :conditions => ["user_id = ?",current_user.id])
    
    @max ||= 100
    @min ||= 0
    
    
    @dates = []
    @start_date.upto(@end_date) do |date|
      @dates << date
    end
    
    
    @counts = {}
    
    @websites.each do |website|
      website.counts.from_date(@start_date).to_date(@end_date).each do |count|
        c = nil
        c = @counts[count.created_at.strftime("%d%m%y")]
        c ||= []
        
        c << count
        @counts[website.url] = {} if @counts[website.url].nil?
        @counts[website.url][c.first.created_at.strftime("%d%m%y")] = c
      end
    end
    
    
    
    @steps = (@max - @min) / 10
  end
  
  def website
    @end_date = Date.today
    @start_date = @end_date - 30
    
    @websites = [Website.find(params[:id])]
    @min = @websites.collect { |web| web.counts.from_date(@start_date).to_date(@end_date).collect(&:count).min }.min rescue nil
    @max = @websites.collect { |web| web.counts.from_date(@start_date).to_date(@end_date).collect(&:count).max }.max rescue nil
    @max ||= 100
    @min ||= 0
    
    
    @dates = []
    @start_date.upto(@end_date) do |date|
      @dates << date
    end
    
    
    @counts = {}
    
    @websites.each do |website|
      website.counts.from_date(@start_date).to_date(@end_date).each do |count|
        c = nil
        c = @counts[count.created_at.strftime("%d%m%y")]
        c ||= []
        
        c << count
        @counts[website.url] = {} if @counts[website.url].nil?
        @counts[website.url][c.first.created_at.strftime("%d%m%y")] = c
      end
    end
    
    
    @counts.keys.each do |w|
      @dates.each do |kk|
        k = kk.strftime("%d%m%y")
        if @counts[w][k]
          puts k
          puts @counts[w][k][0] ? w+@counts[w][k][0].created_at.to_s : nil
          #puts @counts[w][k][1] ? w+@counts[w][k][1].created_at.to_s : nil
        end
      end
    end
    @steps = (@max - @min) / 10
    
    render "websites"
  end

end
