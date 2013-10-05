require 'set'

class MainController < ApplicationController
  before_action :connect
  before_action :get_playlist
  before_action :get_current_song

  def index
    # mpd.play if mpd.stopped?
    # song = mpd.current_song

    directory = Directory.change_directory('')
    @files = directory.content


    #
    #tree = Set.new
    #to_tree2(@mpd.directories, tree, "/")
    #@files = tree



  end

  def change_directory

    @current_directory = params[:path]
    @parent = @current_directory.rpartition('/')[0]
#binding.pry

    directory = Directory.change_directory(@current_directory)
    @files = directory.content


    #binding.pry
    render :index
  end

  def get_playlist
    @queue = @mpd.queue
  end

  def get_current_song
    @current_song = @mpd.current_song
  end

  def connect
    @mpd = MPD.new('192.168.2.108', 6600)
    @mpd.connect
  end

def to_tree2(directories, tree, parent)
  Array(directories).each do |dir|
    p = "#{parent}"
    dir.slice!(p)

    # binding.pry

    if dir.length > 0
      # r = Regexp.new(/^\/([^\/]*)/)
      r = Regexp.new(/([^\/]*)/)
      m = r.match(dir)

      if m
      first_nested_child_dir = m[1]
      else
        first_nested_child_dir = dir
      end
      # binding.pry

      child_dir = OpenStruct.new(:parent => p, :name => first_nested_child_dir)
    else
      child_dir = OpenStruct.new(:parent => p, :name => "..")
    end

    tree.add(child_dir)
  end
end

  def to_tree(directories, tree)

    Array(directories).each do |dir|
      ary = dir.split(/\//, 2)

      tree.add(ary[0])
    end

    tree
  end
end
