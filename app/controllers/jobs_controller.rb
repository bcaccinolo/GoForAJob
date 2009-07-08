class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.xml
  def index
    @categories = Category.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.rss do
        @jobs = Job.latest(Locale.language_code)
        render :action => "jobs", :layout => false
      end
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    unless params.nil? or params[:job].nil?
      @job = Job.new(params[:job])
    else
      @job = Job.new
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end
  
  def preview 
    @job = Job.new(params[:job])
  
    if !@job.valid?
      render :action => "new"
      return
    end
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    params[:job][:status] = "TO_VALIDATE"
    params[:job][:language] = Locale.language_code
    @job = Job.new(params[:job])
  
    respond_to do |format|
      if @job.save
        flash[:notice] = 'Job was successfully created. Your offer will be validated soon.'
        UserNotifier.deliver_waiting_validation
        format.html { redirect_to(@job) }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        flash[:notice] = 'Job was successfully updated.'
        format.html { redirect_to(@job) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def waiting_for_validation
    @jobs = Job.find :all, :conditions => "status = 'TO_VALIDATE'"
    puts YAML::dump(@jobs)
  end
  
  def validate
    @job = Job.find(params[:id])
    @job.update_attribute(:status, "OK")
    @tweet = TweetApp::ClientContext.status(:post, "#{@job.location}, #{@job.title} at #{@job.company}: #{url_for(@job)}"[0,139])
    
    redirect_to(:action => "waiting_for_validation")
  end
  
  def search
    query_source = params[:search].nil? ? params[:request] : params[:search][:request]
    source = params[:source]
    job_filter = "language:#{Locale.language_code} AND status:OK"
    
    
    
    # extend the query with '*'s
    query = query_source.split.map!{|q| "*#{q}*" }.join ' '
    
    if source == "main"
      @jobs = query_source.blank? ? 
                        Job.latest(Locale.language_code) :
                        Job.find_by_contents("#{query} AND #{job_filter}")      
            
      @jobs_cat1 = []
      @jobs_cat2 = []
      @jobs_cat3 = []
      @jobs_cat4 = []      
      @jobs.each do |job|
        puts job.category_id.class
        case job.category_id 
        when 1:
          @jobs_cat1 << job
        when 2:
          @jobs_cat2 << job 
        when 3:
          @jobs_cat3 << job 
        when 4:
          @jobs_cat4 << job 
        end
      end

      render :update do |page|
            page.replace_html "cat1_job_list", :partial => @jobs_cat1
            page.replace_html "cat2_job_list", :partial => @jobs_cat2
            page.replace_html "cat3_job_list", :partial => @jobs_cat3
            # page.replace_html "cat4_job_list", :partial => @jobs_cat4
      end
      return 
    end
          
    # else search in a specific category
    @jobs = query_source.blank? ? 
                      Job.find(:all, :conditions => ["category_id = ? ", source]) :
                      Job.find_by_contents("#{query} AND category_id:#{source} AND #{job_filter}")      
    render :update do |page|
          page.replace_html "cat#{source}_job_list", :partial => "jobs/job", :collection => @jobs
    end
    return 

  end
  
end


