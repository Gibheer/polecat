$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'fileutils'
require 'polecat'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

def prepare_index_dir
  path = File.expand_path(File.dirname(__FILE__) + '/index_dir')
  begin
    FileUtils.rm_r path
  rescue SystemCallError
    # the directory structure is not there, so just
    # ignore it and print a hint
    puts "error occured, but was ignored: $!"
  end
  Dir.mkdir path
  return path
end

module Spec
  class FooDocument
    include Polecat::Document

    field :id
    field :name, :lazy => true
    field :lastname, :lazy => true
    field :description, :analyze => true, :lazy => true
  end
end
