namespace :db do
  desc 'Drop, create, migrate, seed and populate sample data'
  task prepare: %i[reset populate_sample_data] do
    puts 'Ready to go!'
  end

  task :populate_sample_data do
    require 'sample_data/sample_data'

    puts 'Creating Products.'
    SampleData::ProductHelper.create_products
  end
end
