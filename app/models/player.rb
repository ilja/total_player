class Player
  def self.current_song
    new().current_song
  end

  def self.play_pause
    new().play_pause
  end

  def self.pause
    new().play_pause
  end

  def self.next
    new().next
  end

  def self.previous
    new().previous
  end

  def self.paused?
    new().paused?
  end

  def self.play_now(position)
    new().play_now(position)
  end

  def current_song
    mpd { |mpd| mpd_get_current_song }
  end

  def play_pause
    mpd { |mpd| mpd_play_pause }
  end


  def next
    mpd { |mpd| mpd_next }
  end

  def previous
    mpd { |mpd| mpd_previous }
  end

  def paused?
    mpd { |mpd| mpd_paused? }
  end

  def play_now(position)
    mpd { |mpd| mpd_play_now(position) }
  end

  def mpd_get_current_song
    @mpd.current_song
  end

  def mpd_play_pause
    if @mpd.stopped?
      @mpd.play
    else
      if @mpd.paused?
        @mpd.pause = false
      else
        @mpd.pause = true
      end
    end
  end

  def mpd_paused?
    @mpd.paused?
  end


  def mpd_next
    @mpd.next
  end

  def mpd_previous
    @mpd.previous
  end

  def mpd_play_now(position)
    @mpd.play(position)
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