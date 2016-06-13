require_relative './song_library.rb'


require 'pry'

def jukebox(command)
  if command.downcase == "list"
    list_library
    command = nil
    re_run
  else
    parse_command(command)
  end
end

def list_library
  lib = full_library
  lib.each do |artist, album_hash|
    puts list_artist(artist, album_hash)
  end
end

def parse_command(command)
  is_song = false
  full_library.each do |artist, album_hash|
    album_hash.each do |album_key, albums|
      albums.each do |album_title, songs_hash|
        songs_hash.each do |song_key, songs|
          songs.each do |song|
            if song.downcase == command.downcase
              is_song = true
            end
          end
        end
      end
    end
  end

comm_sym = command.split.map(&:capitalize).join(' ').to_sym

  
  if is_song == true
    play_song(command, full_library)
  elsif full_library.has_key?(comm_sym) == true
    parse_artist(command, full_library)
  else
    not_found(command)
  end

re_run
end

def parse_artist(command, lib)
  cmd = command.split.map(&:capitalize).join(' ').to_sym
  parsed = false
  if lib.has_key?(cmd) == true
    puts list_artist(command.split.map(&:capitalize).join(' '), lib[cmd])
    parsed = false
  else
    lib.each do |artist, hash|
      if command.downcase == artist.to_s.gsub("_"," ").downcase
        puts list_artist(artist, lib)
        parsed = true
      end
    end
  end
  parsed
end

def play_song(command, lib)
  lib.each do |artist, hash|
    hash.each do |album_name, albums_hash|
      albums_hash.each do |album, songs_hash|
        songs_hash.each do |song_key, songs|
          songs.each do |song|
            if song.downcase == command.downcase
            puts "Now Playing: #{artist}: #{album} - #{song}\n\n"
            return true
            end
          end
        end
      end
    end
  end
  false
end

def list_artist(artist, album_hash)
   artist_list = "\n---------------\n"
   artist_list += "#{artist}:\n"
   artist_list += "---------------"
   album_hash[:albums].each do |album_name, songs_hash|
     artist_list += "\n#{album_name}:\n\t"
     artist_list += songs_hash[:songs].join("\n\t")
   end
   artist_list
end

def not_found(command)
  puts "I did not understand '#{command}'!\n\n"
  true
end