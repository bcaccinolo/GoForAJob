# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '59c4c0107202a38c16ede30805030b9e'

  before_filter :set_locale

  def set_locale
    
    url = request.env['HTTP_HOST']
    unless url.match(/\.fr$/).nil? and url.match(/^fr\./).nil? 
      Locale.set 'fr-FR'          
    else 
      Locale.set 'en-EN'    
    end
    # Locale.set 'fr-FR'          
    # Locale.set 'en-EN'    
  end

end
