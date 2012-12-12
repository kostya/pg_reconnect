require 'active_record'
require 'active_record/connection_adapters/postgresql_adapter'

# Hackety monkey patch
if ActiveRecord::VERSION::STRING < '3'
  require File.join(File.dirname(__FILE__), %w{ar23})
elsif ActiveRecord::VERSION::STRING >= '3'
  require File.join(File.dirname(__FILE__), %w{ar3})
end
