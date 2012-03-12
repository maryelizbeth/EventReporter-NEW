# Dependencies 
#$LOAD_PATH << './' -- WITH A LOT OF REQUIREMENTS, DEFINE GLOBAL VARIABLE AND SHOVEL CURRENT DIRECTORY
require 'csv'
require 'sunlight'
# require './attendee'

# Class Definition 
class EventManager 
  # attr_accessor :attendees 
  #CSV_OPTIONS {:headers => true, :header_converters => :symbol}
  INVALID_ZIPCODE = "00000"
  INVALID_PHONE = "0000000000"
  INVALID_EMAIL = "  "

  Sunlight::Base.api_key = "e179a6973728c4dd3fb1204283aaccb5"

  def initialize(filename)
    puts "EventManager Initialized."
    @file = CSV.open(filename, :headers =>true, :header_converters => :symbol)
    # load_attendees
  end
    #@file.each do |line|
     #puts line.inspect
     #end

  # EXECUTING BLOCKS 
  # def load_attendees(file)
  #   file.rewind 
  #   self.attendees = file.collect { |line| Attendee.new(line) }
  #   end
  # end 

  # def attendees 
  #   @attendees.each do |attendee|
  #     yield attendee if block_given? 
  #   end
  # end 

  # def attendees(&block)
  #   @attendees.each do |attendee|
  #     block.call(attendee) unless block.nil? 
  #   end 
  # end 

  def print_names 
    # puts "Printing first and last names"
    # @file.each do |line| 
    #   first_name = line[:first_name]
    #   last_name = line[:last_name]
    #   puts [line[:first_name] + " " + line[:last_name]].join(" ")
    #   puts line.inspect
    # end
   end
    

  def clean_numbers(phone_number)
     phone_number = phone_number.scan(/\d/).join
      if phone_number.length == 10
      phone_number
    elsif phone_number.length == 11 && phone_number.start_with?("1")
      phone_number[1..-1]
    else
      phone_number = "0"*10
    end 
  end

  def print_names_numbers
    # @file.each do |line| 
    #     puts [line [:first_name], 
    #     line[:last_name], 
    #     clean_numbers(line[:homephone])].join(" ")
    # end
  end

  def clean_zipcode(original)
    if original.nil? 
      result = INVALID_ZIPCODE  
      return result 
    elsif original.length < 5 
      
      # #WHILE LOOP (CALCULATE MISSING ZEROS) // preferred 
      while original.length <= 4 
        original.insert(0, '0')
      end
      
      return original

      #STRING METHOD 
      #until original.length == 5
        #original.insert (0, '0')
      #end

      # CALCULATE FIXNUM ZEROS 
      # x = 5 - original.length 
      # return "#{0*x}" + original

    else 
      return original 
    end 
  end 

  def print_zipcodes 
     @file.each do |line| 
        zipcode = clean_zipcode(line[:zipcode])
        puts zipcode
      end 
  end 

  def rep_lookup 
    20.times do
      line = @file.readline

      representative = "unknown"
      #API LOOKUP
      puts "#{line[:last_name]}, #{line[:first_name]}, #{line[:zipcode]}, #{representative}"
      legislators = Sunlight::Legislator.all_in_zipcode(clean_zipcode(line[:zipcode]))
      names = legislators.collect do |leg|
        first_name = leg.firstname
        first_initial = first_name[0]
        last_name = leg.lastname
        first_initial + ". " + last_name
      end
      puts "#{line[:last_name]}, #{line[:first_name]}, #{line[:zipcode]}, #{names.join(", ")}"
    end
  end  

  def output_data(filename)
       output = CSV.open(filename, "w")
    @file.each do |line|
      if @file.lineno == 2
        output << line.headers 
      end
      line[:homephone] = clean_numbers(line[:homephone])
      output << line
    end
  end

  def create_form_letter 
    letter = File.open("form_letter.html", "r").read 
    20.times do 
      line = @file.readline 
      custom_letter = letter.gsub("#first_name", line[:first_name])
      custom_letter = custom_letter.gsub("#last_name",line[:last_name])
      custom_letter = custom_letter.gsub("#street", line[:street])
      custom_letter = custom_letter.gsub("#city", line[:city])
      custom_letter = custom_letter.gsub("#state", line[:state])
      custom_letter = custom_letter.gsub("#zipcode", line[:zipcode])  
      filename = "output/thanks_#{line[:last_name]}_#{line[:first_name]}.html"
      output = File.new(filename, "w")
      output.write(custom_letter)
    end
  end
  def rank_times 
    hours = Array.new(24){0}
    @file.each do |line|
      # Counting goes here 
      regdate = line[:regdate]
      my_string = regdate
      parts = my_string.split(" ")
      hour = parts[1].split(":")
      # puts hour 
      hours[hour.to_i] = hours[hour.to_i] + 1
    end
      puts hours.each_with_index{|counter,hour| puts "#{hours}\t#{counter}"}
  end

  def day_stats 
    days = Array.new(7){0}
    @file.each do |line|
      date = Date.strptime(line[:regdate], "%m/%d/%Y")
      puts date.wday
      #looks like saturday [6] & Friday [5] are the primary reg days
    end  
  end 

  def state_stats
    state_data = {}
    @file.each do |line|
      state = line[:state]  # Find the State
      if state_data[state].nil? # Does the state's bucket exist?
        state_data[state] = 1 # If that bucket was nil then start it with this one person
      else
        state_data[state] = state_data[state] + 1  # If the bucket exists, add one
      end
    end
    state_data.each do |state,counter|
      # puts "#{state}: #{counter}"
    end
    state_data = state_data.select{|state, counter| state}.sort_by{|state, counter| state unless state.nil?}
    state_data.each do |state, counter|
    puts "#{state}: #{counter}" #puts alphabetical list of states and counts
    end

    #below code will order ascending - descending count for states 
    # state_data = state_data.select{|counter, state| state}.sort_by{|counter, state| state unless state.nil?}
    # state_data.each do |counter, state|
    # puts "#{state}: #{counter}"
    # end

    # ranks = state_data.sort_by{|state, counter| -counter}.collect{|state, counter| state}
    # state_data = state_data.select{|state, counter| state}.sort_by{|state, counter| state}
    # state_data.each do |state, counter|
    # puts "#{state}:\t#{counter}\t(#{ranks.index(state) + 1})"
    # end
  end 
end

# Script 
em = EventManager.new("event_attendees.csv")
em.rank_times

