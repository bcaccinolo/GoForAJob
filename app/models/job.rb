class Job < ActiveRecord::Base

  acts_as_ferret :fields  => [ :company, :title, :location, :description, :instructions,
      :category_id, :language, :status ],
     # :ferret => { :analyzer => MyAnalyzer.new },
     :remote => false

  belongs_to :category

  validates_presence_of :company
  # validates_presence_of :url
  validates_presence_of :title
  validates_presence_of :location  
  validates_presence_of :description
  validates_presence_of :instructions

  attr_accessor :html_content

  def self.latest(language_code)
    find( :all, 
          :limit => 10, 
          :conditions => " language = '#{language_code}'" 
    )
  end





  def strip_diacritics(s)
      # latin1 subset only
      s.tr("ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙÚÛÜÝàáâãäåçèéêëìíîïñòóôõöøùúûüýÿ",
           "AAAAAACEEEEIIIINOOOOOOUUUUYaaaaaaceeeeiiiinoooooouuuuyy").
        gsub(/Æ/, "AE").
        gsub(/Ð/, "Eth").
        gsub(/Þ/, "THORN").
        gsub(/ß/, "sz").
        gsub(/æ/, "ae").
        gsub(/ð/, "eth").
        gsub(/þ/, "thorn")
    end

end
