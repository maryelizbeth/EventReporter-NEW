#Dependencies
require 'csv'
# require './event_data_parser'
# require './search'
# require './EventReporterCLI'

#Class Definition
class Queue < Array
  attr_accessor :queue

  #@attribute = parameters[3]
  # def initialize
  #   @queue = Queue.new.call
  # end

  def call(parameters)
    "Running queue sub-function #{parameters[0]}"
  end

  def self.valid_parameters_for_queue?(parameters, queue)
    if !%w(count clear print save).include?(parameters[0])
      return true

    elsif parameters [0] == "count"
      @queue.count 
      puts "There are #{@queue.count} items in the queue"

    elsif parameters [0] == "clear"
      if @queue == []
        puts "The Queue has been cleared." 
      else
        @queue == []
        puts "Clearing your queue."
      end
      
    elsif parameters[0] == "print"  
      queue.select do |line|  
        print "LAST NAME".ljust(16) + "FIRST NAME".ljust(20) + "EMAIL".ljust(40) +
        "ZIPCODE".ljust(20) + "CITY".ljust(24) + "STATE".ljust(20) + "ADDRESS\n"

        print "#{line.last_name}".capitalize.ljust(16) +
        "#{line.first_name}".capitalize.ljust(20) +
        "#{line.email_address}".capitalize.ljust(40) +
        "#{line.zipcode}".capitalize.ljust(20) +"#{line.city}".capitalize.ljust(24)
        + "#{line.state}".upcase.ljust(20) + "#{line.street}\n"   
      end   
      puts "Printing your queue results."

    elsif parameters.count == 1 || (parameters[1] == "by" && parameters.count ==3 )
      @queue.sort_by(@attribute) 
      @queue.select do |line| 
      
         print "LAST NAME".ljust(16) + "FIRST NAME".ljust(20) + "EMAIL".ljust(40) +
        "ZIPCODE".ljust(20) + "CITY".ljust(24) + "STATE".ljust(20) + "ADDRESS\n"

        print "#{line.last_name}".capitalize.ljust(16) +
        "#{line.first_name}".capitalize.ljust(20) +
        "#{line.email_address}".capitalize.ljust(40) +
        "#{line.zipcode}".capitalize.ljust(20) +"#{line.city}".capitalize.ljust(24)
        + "#{line.state}".upcase.ljust(20) + "#{line.street}\n"   
      end 

    elsif parameters[0] == "save"
      parameters[1] == "to" && parameters.count == 3 
      output = CSV.open(parameters[2], "w")
      @queue.each do |attendee|
        output << attendee.to_s.join("\t")
        output.close
      end
      puts "Saving your queue"
      #new(filename, mode="r" [, opt]) -- this should write a new file // try to use this method? 
    else 
      return false
    end 
  end 
end 