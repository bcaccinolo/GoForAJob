
class ActiveRecord::Base
    
    def self.dump_fixture_model
      @obj = self.new
      @attributes = @obj.attribute_names
        
      puts "#{@obj.class.to_s.downcase}:"
      # puts "  id: "
      @attributes.each do |attribute|
        unless  attribute == "created_at" or attribute == "updated_at"
          puts "  #{attribute}: " 
        end
      end
    end
          
end



