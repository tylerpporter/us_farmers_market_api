require './db/csv/farmers_market_generator.rb'

namespace :db do
  namespace :seed do
    desc "Seeds the db from CSV files"
    task :from_csv => :environment do
      ModelGenerator.destroy_and_create
      ActiveRecord::Base.connection.tables.each do |t|
        ActiveRecord::Base.connection.reset_pk_sequence!(t)
      end
    end
  end
end
