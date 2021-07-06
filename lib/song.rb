require "pry"
class Song
  attr_accessor :name, :artist_name

  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = Song.new
    @@all << song 
    song
  end

  def self.new_by_name name
    song = Song.create
    song.name = name
    song
  end

  def self.create_by_name name
    song = Song.new_by_name(name)
    song
  end

  def self.find_by_name name
    song = @@all.find{|song| song.name == name} #=> return the first instance object if there is matches
    #find method in Ruby returns the first matching OBJECT, NOT an array of the one object.
    
    #if the is any match , song below will be a true value and return the song
    #if there isn't any match in above find method, song below will be false, and return false. 
    song ? song : nil

  end

  def self.find_or_create_by_name name
    Song.find_by_name(name) ? Song.find_by_name(name) : Song.create_by_name(name)
  end

  def self.alphabetical
    @@all.sort_by{|song| song.name}
  end

  def self.new_from_filename filename
    #breakdown the name and artist_name
    artist_name = filename.split(" - ")[0]
    song_name = filename.split(" - ")[1].split(".")[0]
    song = Song.find_or_create_by_name(song_name)
    song.artist_name = artist_name
    song
  end

  def self.create_from_filename filename
    Song.new_from_filename(filename)
  end

  def self.destroy_all
    @@all = []
  end

end

song_1 = Song.create_by_name("Thriller")
song_2 = Song.create_by_name("Blank Space")
song_3 = Song.create_by_name("Call Me Maybe")
# binding.pry