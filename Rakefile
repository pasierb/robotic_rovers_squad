require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
	t.libs << "test"
 	t.test_files = FileList['test/test*.rb']
end

task :default do
	Rake::Task["test"].invoke
end