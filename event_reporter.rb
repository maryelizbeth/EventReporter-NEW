#Dependencies 
require 'csv'
require 'ostruct'

#Class Definition 

class EventReporter

EXIT_COMMANDS = ["quit", "q", "e", "x", "exit"] 

ALL_COMMANDS = ["find", "find <attribute> <criteria>", "help <command>", "load <filename>", "queue clear",
"queue count", "queue print", "queue print <attribute>", "queue save to <file>"]

COMMAND = ""

INVALID_ZIPCODE = "XXXXX"

  def run 
    puts "Welcome to the EventReporter"
    command = "" 
    @all_commands = {"load" => "loads a new file", "help" => "shows a list of available commands",
                     "queue count" => "total items in the queue", "queue clear" => "empties the queue",
                     "queue print" => "prints to the queue", "queue print by" => "prints the specified attribute",
                     "queue save to" => "exports queue to a CSV", "find" => "load the queue with matching records"}

    until EXIT_COMMANDS.include?(command)
      puts "Please enter a command > "
      input = gets.strip
      command = input.split.first 

      if command == "load"
        filename = input.split[1]
        @file = CSV.open(filename, :headers =>true, :header_converters => :symbol)
        puts "Loading the data file #{filename}"

      elsif command.length >= 2 
        if command.(1) ==@all_commands 
        puts "This is a definition of the command"
      end 
      # elsif command == "help"
      #   puts "Below is a list of valid commands."
      #   puts [ALL_COMMANDS] 

    else 
      puts "That was not a valid command."
      end
    end
  end
end

#Scripts 
er = EventReporter.new
er.run