class GraphController < ApplicationController
  
  def websites
    @websites = Website.all(:include => :counts)
    @min = @websites.collect { |web| web.counts.collect(&:count).min }.min
    @max = @websites.collect { |web| web.counts.collect(&:count).max }.max
    
    dates = Website.all.collect { |web|  [web,web.counts.count] }.max_by{|m|m[1]}.first.counts.collect{|c| c.created_at.strftime("%d%m%y")}
    @dates = []
    dates.each do |date|
      @dates << date unless @dates.include?(date)
    end
    
    
    @counts = {}
    
    @websites.each do |website|
      website.counts.each do |count|
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
  end
  
  def website
    @website = Website.find(params[:id], :include => :counts)
    @min = @website.counts.collect(&:count).min
    @max = @website.counts.collect(&:count).max
    @steps = (@max - @min) / 10
  end

end
