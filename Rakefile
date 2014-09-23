require 'pry'
require 'fileutils'

task :default do
	puts "hello"
end

namespace :greetings do
	desc "greets a person by name"
	task :greet, [:name] do |cmd, args|
		puts "hey what's up, #{args[:name]}"
	end
end

namespace :cake do
 
 #dependency
  desc "Bake a Cake"
  task :bake => [:mix_up, :go_to_store] do
    puts "Cake is baked"
  end
 
  task :mix_up => [:add_flour, :add_eggs] do
    puts "Mix up ingredients"
  end
 
  task :add_flour => :get_flour do
    puts "Adding flower"
  end
 
  task :add_eggs => :go_to_store do
    puts "Adding Eggs"
  end
 
  task :get_flour => :go_to_store do
    puts "Get Flower"
  end
 
  task :go_to_store do
    puts "Go to Store"
  end

desc "things I can't spell"
  task :learn_how_to_spell, [:word] do |cmd, args|
  	puts "need to learn how to spell, #{args[:word]}"
  end
end



namespace :dozer do
desc "print ENV"
	task :env do
#execute shell commands
		sh("ENV")
	end

desc "print PWD"
	sh("pwd")
	task :pwd do
	end

desc "adds views for a resource"
	task :make_views, [:resource_name] do |cmd, args|
		resource = args[:resource_name]
		sh("mkdir views/#{resource}")
		FileUtils.touch("views/#{resource}/new.erb")
		FileUtils.touch("views/#{resource}/index.erb")
		FileUtils.touch("views/#{resource}/show.erb")
		FileUtils.touch("views/#{resource}/edit.erb")
		# mkdir(args[:resource])
		# cd(args[:resource])
		# File.open('new.erb', 'edit.erb', 'index.erb', 'show.erb')
	end

end

namespace :db do
	desc "create database"
	task :create, [:name] do |cmd, args|
	sh("createdb #{args[:name]}")
end

desc "drop db"
task :drop do
	sh("dropdb dvr_app_test")

end
end



