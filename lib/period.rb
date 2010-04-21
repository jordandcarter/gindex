class Period
  
  def initialize(days_ago)
    @days_ago = days_ago.to_i
  end
  
  def to_s
    @days_ago.days.ago.strftime("%d %b, %A")
  end
  
  def days
    @days_ago
  end
  
  def to_date
    @days_ago.days.ago
  end
  
end
