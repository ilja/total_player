require 'spec_helper'
require 'rbtree'
require 'tree'
require 'set'

describe "mpd dingen" do
  it "should fkladfjas" do
    mpd = MPD.new('192.168.2.108', 6600)
    mpd.connect

    mpd.play if mpd.stopped?
    song = mpd.current_song

    #     puts "Current Song: #{song.artist} - #{song.title}"

    #     mpd.queue.each do |song|
    #       puts "#{song.artist} - #{song.title}"
    #     end

    #     # tree = Tree::TreeNode.new("root")
    #     tree = Set.new
    #     directories = to_tree(mpd.directories, tree)

    #     directories.each do |dir|
    #       puts "#{dir}"
    #     end

    # binding.pry
    parent = "Funk"
    rocksub = mpd.files(parent)[:directory]
    # binding.pry
    tree2 = Set.new
    dir2 = parse_filesystem_tree(rocksub, tree2, parent)

    tree2.each do |d|
      puts d.name
    end

  end
end

def to_tree(directories, tree)

  Array(directories).each do |dir|
    ary = dir.split(/\//, 2)

    tree.add(ary[0])
  end

  tree
end

def parse_filesystem_tree(directories, tree, parent)
  Array(directories).each do |dir|
    p = "#{parent}"
    dir.slice!(p)

    if dir.length > 0
      r = Regexp.new(/^\/([^\/]*)/)
      m = r.match(dir)
      first_nested_child_dir = m[1]
      # binding.pry

      child_dir = OpenStruct.new(:parent => p, :name => first_nested_child_dir)
    else
      child_dir = OpenStruct.new(:parent => p, :name => "..")
    end

    tree.add(child_dir)
  end
end
