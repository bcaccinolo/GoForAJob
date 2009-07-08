
class MyAnalyzer < Ferret::Analysis::Analyzer
  
  include Ferret::Analysis  

  def token_stream(field, str)
    @stop_words = []

    mapping = {
      ['a']         => 'b',
      'c'                                       => 'd'
    }
    
    puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< USING IT !!!!!!!!!!! ON #{str}"
    ts = StandardTokenizer.new(str)
    ts = HyphenFilter.new(ts)    
    ts = LowerCaseFilter.new(ts) # lower is true§    
    ts = StopFilter.new(ts, @stop_words)    
    ts = MappingFilter.new(ts, mapping)
  end
end
