$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'aruba/cucumber'
# Ensure aruba can find the bin folder
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

#require 'sqldump'
