#Dependencies 
require 'csv'
require 'sunlight'

#Class Definition 
class EventReporter 

  INVALID_ZIPCODE = "00000"
  INVALID_PHONE = "0000000000"
  INVALID_EMAIL = "  "

  Sunlight::Base.api_key = "e179a6973728c4dd3fb1204283aaccb5"

  def initialize(filename)
    puts "initializing..."
    @file = CSV.open(filename, :headers =>true, :header_converters => :symbol)
  end 
end 

#Scripts 
er = EventReporter.new
