
mpd = MPD.new('192.168.2.108', 6600, {callbacks: true})
mpd.connect

mpd.on :volume do |volume|
  MessageBus.publish "/channel", "Volume was set to #{volume}!"
end

mpd.on :song do |song|
  MessageBus.publish "/channel", song_change(song).to_json
end


def song_change(song)
  {
    :event => 'song_change',
    :id => song.id,
    :artist => song.artist,
    :title => song.title
  }
end

# proc = Proc.new {|song| puts "Current song was set to #{song}!" }
# mpd.on :song, &proc
