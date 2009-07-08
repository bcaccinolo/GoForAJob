class CategoriesController < ApplicationController
  
  layout "jobs"
  
  def jobs
    cat_id = params[:id]
    @category = Category.find cat_id
    @jobs = @category.all_jobs(Locale.language_code)
    
    respond_to do |format| 
      
      format.html
      format.rss { render :action => "../jobs/jobs", :layout => false}
      
    end
    
    
  end
  
end
