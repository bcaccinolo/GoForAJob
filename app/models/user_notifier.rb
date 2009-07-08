class UserNotifier < ActionMailer::Base
  def waiting_validation
    setup_email
    @subject    += 'A job offer is waiting for Validation '
    @body[:url]  = "http://goforajob.com/jobs/waiting_for_validation"
  end
      
  protected
  def setup_email
    @recipients  = "benoit.caccinolo@gmail.com"
    @from        = "no-reply@goforajob.com"
    @subject     = "[GoForAJob] "
    @sent_on     = Time.now
  end
end
