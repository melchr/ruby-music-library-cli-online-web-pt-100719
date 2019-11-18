require_relative '../config/environment'

class Artist
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all = []
  def initialize(artist_name)
    @songs = []
    @name = artist_name
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
  
  def self.create(name_of_artist)
    artist_obj = self.new(name_of_artist)
    artist_obj.save
    artist_obj
  end
  
  def add_song(song_obj)
    song_obj.artist = self unless
    song_obj.artist != nil
    @songs << song_obj unless @songs.include?(song_obj)
  end
  
  def genres
    genre_collection = @songs.collect {|song| song.genre}.uniq
    genre_collection
  end
  
end