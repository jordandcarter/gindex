class Counter

  require 'config/environment' #only if you are using this within a rails app
  require 'hpricot'
  require 'open-uri'
  require 'pp'
  require 'htmlentities'


  #get info from google
  def self.grab(keyword, inurl= nil,keyword_object = nil)
  
    # Settings!
    search = keyword
    
    total_parse = 0
    
    data = 0
    
    #search = "#{Grabba.clean_keywords(search)}" #remove crap from keywords and convert for googlesearch url
    #begin
      #url = "http://www.google.co.nz/search?num=#{per_page}&hl=en&q=&btnG=Search&start=#{page*per_page}&meta="
      url = "http://www.google.co.nz/search?q=site:#{search}"
      url = "http://www.google.co.nz/search?q=site:#{search}+inurl:#{inurl}" if inurl
              
        recieved = false;
        try_count = 0
        while !recieved && try_count < 5
          begin #catch timeouts
            page_response = open(url, 
            "User-Agent" => random_user_agent,
            "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Accept-Language" => "en-us,en;q=0.5",
            "Accept-Charset" => "ISO-8859-1,utf-8;q=0.7,*;q=0.7",
            "Keep-Alive" => "300",
            "Connection" => "keep-alive",
            "Referer" => "http://www.google.co.nz/search?&hl=en&btnG=Search&meta="
            )
          recieved = true
          rescue
          try_count += 1
          puts "Error occured trying to get page, trying again.. #{try_count} / 5"
          end
        end
        
        zipped = false
        #begin
        #  gz = Zlib::GzipReader.new(page_response)
        #  html_page = gz.read
        #  zipped = true
        #rescue Zlib::GzipFile::Error
        #  puts "PAGE NOT GZIPPED"
        #  puts "NEED TO CAPTURE PROPERLY, CHECK FOR BLOCK!"
        #  throw Error.new
          html_page = page_response
        #end
        
        #begin
        #  outfile = File.new("last_response.html", "w") # write the last recieved page from google to file
        #  outfile.write(html_page.to_s)
        #  outfile.close
        #rescue Exception
        #  puts "unable to write to last_response.html file"
        #end
        doc = Hpricot(html_page)
        data = "0"
        start = Time.now
        i = doc.search('#ssb/p/b[3]')
        i.each do |div|
          data = div.inner_html
        end
    data
  end
  
  #remove crap from keywords and add + where spaces are (for googlesearch url)
  def self.clean_keywords(keywords)
    keywords.gsub!(/[^&A-Za-z01-9 ]\+?/, "") #remove everything but those allowed in the keyword search
    keywords.gsub(' ', '+') #replace spaces with + (for googlesearch url)
  end
  
  def self.random_user_agent
     agents = ["Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6",
     "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)",
     "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30)",
     "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.1.4322)",
     "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT 5.1; .NET CLR 1.1.4322)",
     "Opera/9.20 (Windows NT 6.0; U; en)",
     "Opera/9.00 (Windows NT 5.1; U; en)",
     "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 8.50",
     "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 8.0",
     "Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.02 [en]",
     "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20060127 Netscape/8.1",
     "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4"]
     agents[rand(agents.length)]
  end
end
