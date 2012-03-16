#Dependencies 
# require 'csv'
# require './event_data_parser'
# require './queue'
# require './EventReporterCLI'

#Class Definitions
class Search 

  attr_accessor :queue 

  # def self.for(parameters)
  #   puts "Here's a search for #{parameters.join(" ")}"
  #    puts @queue.size
  #   #in 'event_attendees.csv'
  # end

  def self.valid_parameters?(parameters)
    #Check that attribute is valid 
    if parameters.count == 2 
      puts "Searching for #{parameters}"
      return true
    else 
      "There were no instances of your search."
    end
  end 

  def self.find(parameters, attendees)
    
    attribute = parameters[0]
    criteria = parameters[1..-1].join " "
    @queue = Queue.new

    attendees.each do |attendee|
      if attendee.send(attribute.to_sym).downcase == criteria.downcase
        @queue << attendee
      end
    end

    puts "There are #{queue.count} results in the queue." 
    return queue
  end
end 
