class PlayQueue
  def self.add(path)
    new().enqueue(path)
  end

  def self.clear
    new().clear
  end

  def self.queue
    new().queue
  end

  def enqueue(path)
    mpd { |mpd| mpd_queue(path) }
  end

  def clear
    mpd { |mpd| mpd_clear_queue }
  end

  def queue
    mpd { |mpd| mpd_get_queue }
  end

  def mpd_get_queue
    @mpd.queue
  end

  def mpd_queue(path)
    @mpd.add(path)
  end

  def mpd_clear_queue
    @mpd.clear
  end

  def mpd_get_current_song
    @mpd.current_song
  end

  def mpd(&block)
    @mpd = MPD.new('192.168.2.108', 6600)
    @mpd.connect
    #puts "===============================>> opening mpd"
    yield block
  ensure
    #puts "===============================>> closing mpd"
    @mpd.disconnect
  end
end