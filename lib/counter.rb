class Counter

  require 'config/environment' #only if you are using this within a rails app
  require 'hpricot'
  require 'open-uri'
  require 'pp'
  require 'htmlentities/string'


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
            "User-Agent" => "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4",
            "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Accept-Language" => "en-us,en;q=0.5",
            "Accept-Charset" => "ISO-8859-1,utf-8;q=0.7,*;q=0.7",
            "Keep-Alive" => "300",
            "Connection" => "keep-alive",
            "Referer" => "http://www.google.co.nz/search?num=100&hl=en&btnG=Search&meta=",
            "X-Moz" => "prefetch")#,
            #"Cookie" => 'SS=Q0=cHJvamVjdCB4; PREF=ID=208490125f4598d3:TM=1226974432:LM=1226974432:S=C6DNMw-2IjAEIM1l; NID=17=X3C1qPj4bGtlrxdH0fxbb8wwwHTGcfaC63fndLGwm3hj_A18nTXRNyCEbQ2dFPLXf6fob2a0rHNs48l8wXH_mJJvs8MlYPgB0ZSfojLKbTZt6s4olZK5HEgJrQ9GNRDd')
          
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
end
