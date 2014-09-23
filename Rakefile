namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler'
  end
end

task :environment, [:env] => 'bundler:setup' do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || "development"
  Bundler.require(:default, ENV["RACK_ENV"])
  require "./config/boot"
end

namespace :db do
  desc "creates a db"
  task :create, [:env] do |cmd, args|
    env = args[:env] || "development"
    dbname = "dvr_app"
    sh("createdb #{dbname}_#{env}")
  end

  desc "drop db"
  task :drop, [:env] do |cmd, args|
    env = args[:env] || "development"
    dbname = "dvr_app"
    if
      sh("dropdb #{dbname}_#{env}")
  end

  desc "seed db"
  task :seed, [:env] do |cmd, args|
    # default environment
    env = args[:env] || "development"
    # load up my sinatra environment
    # then populate my database
    # calls rake environment[env]
    Rake::Task['environment'].invoke(env)
    require './db/seeds'
  end

  desc "creates db, applies migrations, seeds db"
  task :setup => ["db:drop"]    do
    Rake::Task['db:create'].invoke(env)
    Rake::Task['db:migrate'].invoke(env)

    Rake::Task['db:seed'].invoke(env)

    # sh("db:drop")
    # sh("db:create")
    # sh("db:migrate")
    # sh("db:seed")
  end
    desc "Rollback the database"
  task :rollback, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    require 'sequel/extensions/migration'
    version = (row = DB[:schema_info].first) ? row[:version] : nil
    Sequel::Migrator.apply(DB, "db/migrations", version - 1)
  end

    desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    require 'sequel/extensions/migration'
    # apply database, migration_folder
    Sequel::Migrator.apply(DB, "db/migrations")
  end
end
