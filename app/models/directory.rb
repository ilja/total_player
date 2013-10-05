require 'set'

class Directory
  def self.change_directory(path)
    dir = new(path)
    dir.change_directory
    dir
  end

  def self.root
    dir = new('')
    dir.change_directory

    dir
  end

  def initialize(path)
    @path = path
    self
  end

  def change_directory
    @files = mpd { |mpd| mpd_files(@path) }
  end

  def parse_filesystem_tree(directories, current_directory)
    tree = Hash.new

    Array(directories).each do |dir|

      if dir.include? '/'
        unless current_directory.blank?
          p = "#{current_directory}/"

          if dir == current_directory
            parent = dir.rpartition('/')[0]
            child_dir = OpenStruct.new(:parent => parent, :name => '..')

          else
            dir.slice!(p)

            if dir.length > 0
              r = Regexp.new(/([^\/]*)/)
              m = r.match(dir)

              if m
                first_nested_child_dir = m[1]
                child_dir = OpenStruct.new(:parent => current_directory, :name => first_nested_child_dir)
              end
            end
          end
        end

      else
        if current_directory.blank?
          child_dir = OpenStruct.new(:parent => "", :name => dir)
        else
          child_dir = OpenStruct.new(:parent => "", :name => "..")
        end
      end

      if child_dir
        tree[child_dir.name] = child_dir unless tree.has_key?(child_dir.name)
      else
      end
    end

    tree

  end

  def directories
    parse_filesystem_tree(@files[:directory], @path)
  end

  def files
    parse_filesystem_tree(@files[:file], @path)
  end

  def content
    a = directories.merge files
    a.collect { |k, v| v }
  end

  def mpd_files(path)
    @mpd.files(path)
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