ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
require "logger"            # ← مهم جدًا مع Ruby 3.2
require "bundler/setup"     # Set up gems listed in the Gemfile.
require "bootsnap/setup"    # Speed up boot time by caching expensive operations.
