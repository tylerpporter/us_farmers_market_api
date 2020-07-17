require './db/csv/model_manager.rb'

namespace :db do
  namespace :seed do
    desc "Seeds the db from CSV files"
    task :from_csv => :environment do
      ModelManager.destroy_and_create_markets
      ActiveRecord::Base.connection.tables.each do |t|
        ActiveRecord::Base.connection.reset_pk_sequence!(t)
      end
    end
  end
end
