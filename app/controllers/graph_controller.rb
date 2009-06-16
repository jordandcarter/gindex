class GraphController < ApplicationController
  
  def websites
    @websites = Website.all(:include => :counts)
    @min = @websites.collect { |web| web.counts.collect(&:count).min }.min
    @max = @websites.collect { |web| web.counts.collect(&:count).max }.max
    @steps = (@max - @min) / 10
  end
  
  def website
    @website = Website.find(params[:id], :include => :counts)
    @min = @website.counts.collect(&:count).min
    @max = @website.counts.collect(&:count).max
    @steps = (@max - @min) / 10
  end

end
