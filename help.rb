#Class Definitions 
class Help

  ALL_COMMANDS = {"load" => "loads a new file", "help" => "shows a list of available commands",
                     "queue count" => "total items in the queue", "queue clear" => "empties the queue",
                     "queue print" => "prints to the queue", "queue print by" => "prints the specified attribute",
                     "queue save to" => "exports queue to a CSV", "find" => "load the queue with matching records"}

  def self.for(parameters)
    if parameters.count == 0
      puts "Please select a command from below:\n"
      ALL_COMMANDS.each{|key, value| puts "#{key}"}

    elsif parameters.count >= 1 
      
      ALL_COMMANDS.each{|key, value| puts "#{value}"} #ammend return to match input key 
      #something needs to go here to compare the input with the keys in ALL_COMMANDS
      
    
    end
  end

  def self.valid_parameters_for_help?(parameters)
      parameters.empty? || EventReporterCLI.valid_command?(parameters.join(" "))
  end  
end