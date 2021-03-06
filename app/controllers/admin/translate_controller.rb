class Admin::TranslateController < ApplicationController

  layout "jobs"


  def index
    Locale.set 'en-US'
    @en_view_translations = ViewTranslation.find(:all, 
      :conditions => [ 'language_id = ? ', Locale.language.id], :order => 'tr_key')
      # :conditions => [ 'language_id = ? and  `tr_key` LIKE CONVERT( _utf8 \'%TR_%\'
      # USING latin1 )', Locale.language.id], :order => 'tr_key')
      # :conditions => [ 'text IS NULL AND language_id = ?', Locale.language.id ], :order => 'tr_key')
      
    Locale.set 'fr-FR'
    @fr_view_translations = ViewTranslation.find(:all, 
    :conditions => [ 'language_id = ? ', Locale.language.id], :order => 'tr_key')
    
  end

  def translation_text
    @translation = ViewTranslation.find(params[:id])
    render :text => @translation.text || ""  
  end

  def set_view_translation_text
    @translation = ViewTranslation.find(params[:id])
    previous = @translation.text
    @translation.text = params[:value]
    @translation.text = previous unless @translation.save
    render :partial => "translation_text", :object => @translation.text  
  end

end
