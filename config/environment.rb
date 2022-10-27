# frozen_string_literal: true

require 'bundler/setup'

Bundler.require(:default, ENV.fetch('RACK_ENV', 'development').to_sym)

require_relative '../spaceholder_app'
