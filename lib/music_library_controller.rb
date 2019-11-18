class MusicLibraryController
  
  attr_reader :path
  
  def initialize(path = './db/mp3s')
    @path = path
    music_obj = MusicImporter.new(path)
    music_obj.import
  end
  
  def call 
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    call_selection = gets.chomp 

    if call_selection != 'exit'
      case call_selection
    when 'list songs'
      list_songs 
    when 'list artists'
      list_artists
    when 'list genres'
      list_genres
    when 'list artist'
      list_songs_by_artist
    when 'list genre'
      list_songs_by_genre
    when 'play song'
      play_song
    end 
    self.call
    end
  end 
  
  def list_songs
    songs = Song.all.sort {|a,b| a.name <=> b.name}
    songs.each.with_index(1){|song,index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    }
  end
  
  def list_artists
    artists = Artist.all.sort{|a,b| a.name <=> b.name}
    artists.each.with_index(1){|artist,index|
      puts "#{index}. #{artist.name}"
    }
  end
  
  def list_genres
    genres = Genre.all.sort{|a,b| a.name <=> b.name}
    genres.each.with_index(1){|genre,index|
      puts "#{index}. #{genre.name}"
    }
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.chomp
    
    if(Artist.find_by_name(artist))
      songs = Song.all.sort{|a,b| a.name <=> b.name}
      songs = songs.select {|song| song.artist.name==artist}
      songs.each.with_index(1){|song,index|
          puts "#{index}. #{song.name} - #{song.genre.name}"
      }
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.chomp
    
    if(Genre.find_by_name(genre))
      songs = Song.all.sort{|a,b| a.name <=> b.name}
      songs = songs.select {|song| song.genre.name==genre}
      songs.each.with_index(1){|song,index|
          puts "#{index}. #{song.artist.name} - #{song.name}"
      }
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    songnum = gets.chomp.to_i
    
    songs = Song.all.sort{|a,b| a.name <=> b.name}
    if songnum > 0 && songnum <= songs.length
      puts "Playing #{songs[songnum-1].name} by #{songs[songnum-1].artist.name}" if(songs[songnum-1])
    end
  end
  
end