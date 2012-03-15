#Dependencies 
require './attendee'
require 'csv'
#require './search'

#Class Definition
class EventDataParser

  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

    def self.initialize (parameters)
      puts "Loading the CSV"
    end

    def self.valid_parameters_for_load?(parameters)
      parameters.count == 1 && parameters[0] =~ /\.csv$/
    end

    def self.load(filename, options = CSV_OPTIONS)
      load_attendees(CSV.open(filename, CSV_OPTIONS))
    end 

    def self.load_attendees(file)
      "Data loaded from #{file}"
      attendees = file.collect {|line| Attendee.new(line)}
      #puts attendees.size 
    end 
 end

 
