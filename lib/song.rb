class Song
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(song_name, artist_obj = nil, genre_obj = nil)
    @name = song_name
    @artist = artist_obj
    self.artist = artist_obj if artist_obj != nil
    self.genre = genre_obj if genre_obj != nil
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name_of_song)
    song_obj = self.new(name_of_song)
    song_obj.save
    song_obj
  end
  
  def artist=(artist_instance)
    @artist = artist_instance
    artist_instance.add_song(self)
  end
  
  def genre=(song_instance)
    @genre = song_instance
    @genre.songs<<(self) unless @genre.songs.include?(self)
  end
  
  def self.find_by_name(song_name) 
    @@all.find {|song| song.name == song_name}
  end 
  
  def self.find_or_create_by_name(song_name)
    self.find_by_name(song_name) || self.create(song_name)
  end
  
  def self.new_from_filename(file_name)
    song_name = file_name.split(" - ")[1].to_s
    artist_name = file_name.split(" - ")[0].to_s
    genre = file_name.split(" - ")[2].split(".")[0].to_s

    if !self.find_by_name(song_name) 
    song = self.find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre)
    end
    song
  end 

  def self.create_from_filename(file_name)
     self.new_from_filename(file_name)
  end 
  
end