
xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0") do 

  xml.channel do 
    xml.title("Recent Jobs")
    xml.link("http://localhost:3000/blog_posts.rss")
    xml.description("Recent jobs posted on Goforajob")
    xml.language('en-us')

	render :partial => "layouts/job", :collection => @jobs, :locals => {:xm => xml}

  end

end


