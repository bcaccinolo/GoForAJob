class Category < ActiveRecord::Base
  
  translates :name
  
  acts_as_ferret :remote => false
  
  has_many :jobs, :order => "created_at", :conditions => "status = 'OK'"
  has_many :jobs_to_validate, :class_name => "Job", :order => "created_at", :conditions => "status = 'TO_VALIDATE'"
  
  def all_jobs(language_code)
    self.jobs.find(:all,:conditions => " language = '#{language_code}'" )
  end
  
  def last_jobs(language_code)
    self.jobs.find(:all, 
      :limit => 10, 
      :conditions => " language = '#{language_code}'" )
  end
  
end
