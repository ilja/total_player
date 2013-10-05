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

  def root
    #change_directory
    #@files = @files[:directory]
    #
    #tree = Hash.new
    #to_tree2(@files, tree, '')
    #
    ##puts tree.size
    #
    #@files = tree
  end

  def to_tree2(directories, tree, current_directory)

    Array(directories).each do |dir|

      if dir.include? '/'
        unless current_directory.blank?
          p = "#{current_directory}/"
          puts "current: #{p} dir: #{dir}"

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
        puts "geen childdir voor: #{dir}"
      end
    end

  end

  def ls
    @files

  end

  def directories


    tree = Hash.new
    to_tree2(@files[:directory], tree, @path)

    #@directories = tree

    tree

  end

  def files


    tree = Hash.new
    to_tree2(@files[:file], tree, @path)

    #@files = tree

    tree
  end

  def content
#binding.pry
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