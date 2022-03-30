# frozen_string_literal: true

require 'bundler/setup'

Bundler.require(:default, (ENV['RACK_ENV'] || 'development').to_sym)

require_relative '../spaceholder'
