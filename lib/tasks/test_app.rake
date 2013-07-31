namespace :test do
  desc "Test services"
  Rake::TestTask.new(:services) do |t|
    t.libs << "test"
    t.pattern = "test/services/**/*_test.rb"
    t.verbose = true
  end
end

Rake::Task["test:run"].enhance { Rake::Task["test:services"].invoke }
