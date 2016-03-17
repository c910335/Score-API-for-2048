require 'rubygems'
require 'bundler/setup'
require 'securerandom'
require 'rack/cors'
require 'active_support/core_ext/string'
require 'grape'
require 'active_record'
require 'grape/activerecord'
require 'grape-entity'
require 'grape-swagger'
require 'grape_logging'
require './config/settings'

Grape::ActiveRecord.configure_from_file! 'config/database.yml'
ActiveRecord::Base.default_timezone = :local
