require 'set'

class MainController < ApplicationController

  before_action :get_playlist
  before_action :get_current_song
  before_action :get_pause_state

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

  def add_to_playlist
    directory = params[:path]

    PlayQueue.add(directory)

    flash[:info] = "Added #{directory} to queue."

    #todo: ajax
    redirect_to change_directory_path(path: params[:current_directory])
  end

  def clear_playlist
    PlayQueue.clear


    redirect_to change_directory_path(path: params[:current_directory])
  end


  def play_pause
    Player.play_pause

    redirect_to change_directory_path(path: params[:current_directory])
  end


  def next
    Player.next

    redirect_to change_directory_path(path: params[:current_directory])
  end

  def previous
    Player.previous

    redirect_to change_directory_path(path: params[:current_directory])
  end

  private

  def get_playlist
    @queue = PlayQueue.queue
  end

  def get_current_song
    @current_song = Player.current_song
  end

  def get_pause_state
    @paused = Player.paused?
  end

end
