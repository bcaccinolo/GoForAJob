

# Geneation of html body
path =  File.dirname(__FILE__) + "/../jobs/body_full.html.erb"          
template = ERB.new(File.readlines(path).join(''), nil, '-')
job.html_content = template.result(binding)


  xm.item do
    xm.title(job.title)
    xm.description( job.html_content )    

    xm.link(job_url(job))        
    xm.guid(job_url(job))                
  end
