
namespace :db do
  namespace :fixtures do 

    desc 'Print out the fixture template of given model with params: Model=ModelName'
    task :template => :environment  do
      
      model = ENV['Model']
      if model.blank? 
        raise "you have to define a model like this Model=ModelName"
      end

      eval("ActiveRecord::Base::#{model}.dump_fixture_model")

    end

  end

end
