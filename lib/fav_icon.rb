class FavIcon
  
  require 'config/environment' #only if you are using this within a rails app
  require 'hpricot'
  require 'open-uri'
  require 'pp'
  require 'htmlentities'
  
  def self.get(url)
    
    
    uri = URI.parse url
    url = URI.build(:scheme => uri.scheme || "http", :host => uri.host, :port => uri.port, :path => uri.path, :path => uri.query, :fragment => uri.fragment)
    
    recieved = false;
    try_count = 0
    while !recieved && try_count < 5
      begin #catch timeouts
        page_response = open(url, 
          "User-Agent" => "RubyFavIconFinder",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language" => "en-us,en;q=0.5",
        "Accept-Charset" => "ISO-8859-1,utf-8;q=0.7,*;q=0.7",
        "Keep-Alive" => "300",
        "Connection" => "keep-alive")
        recieved = true
      rescue
        try_count += 1
        puts "Error occured trying to get page, trying again.. #{try_count} / 5"
      end
    end
    Hpricot(page_response).search('/html/head/link[@type="image/x-icon"]').first["href"]
  end
  
end

#<link type="image/x-icon" href="http://www.wetware.co.nz/blog/wp-content/themes/grey-matter/img/favicon.ico" rel="Shortcut Icon"/>
