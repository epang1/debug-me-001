require_relative './jukebox.rb'
require 'pry'

def run
  puts "Welcome to Ruby Console Jukebox!"
  puts "Enter a command to continue. Type 'help' for a list of commands."
  command = get_command
  while command.downcase != "exit" do
    run_command(command) unless command.downcase == "exit"
  end
end

def get_command
  gets.strip
end

def re_run
  puts "\nEnter a command to continue. Type 'help' for a list of commands."
  command = get_command
  while command.downcase != "exit" do
    run_command(command) unless command.downcase == "exit"
  end
  binding.pry
end

def run_command(command)
  case command
  when "help"
    show_help
    command = nil
    re_run
  else
    jukebox(command)
  end
end

def show_help
  help = "Never worked a jukebox, eh? Pretty standard. Available commands are:\n"
  help += "'help' - shows this menu\n"
  help += "'list' - lists the whole song library\n"
  help += "or you can enter an artist's name to show that artist's songs\n"
  help += "or you can enter an artist's name to show that artist's songs\n"
  puts help
end

run
