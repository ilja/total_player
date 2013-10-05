require 'spec_helper'

describe Directory do
  #describe ".root" do
  #  it 'should show all files or directories under the root' do
  #    #directory = Directory.root
  #    directory = Directory.change_directory('')
  #    result = directory.content
  #
  #    #puts result.inspect
  #
  #    expect(result.size).to eql 24
  #  end
  #
  #
  #
  #
  #end
  #
  #describe "#change_directory(path)" do
  #  #it 'should show all files under the given path' do
  #  #  directory = Directory.change_directory('Audiobooks & Spoken Word')
  #  #  result = directory.ls
  #  #
  #  #  expect(result.size).to eql 193671
  #  #end
  #  #it 'should show all files under the given subpath' do
  #  #  directory = Directory.change_directory('Bob Dylan/Modern Times')
  #  #
  #  #  result = directory.ls
  #  #
  #  #  expect(result.size).to eql 958
  #  #end
  #  it 'should parse directories' do
  #    directory = Directory.change_directory('Bob Dylan')
  #    expected = directory.directories
  #
  #
  #
  #
  #    expect(expected.size).to eql 9
  #  end
  #
  #  it 'should parse files' do
  #    directory = Directory.change_directory('Bob Dylan/Modern Times')
  #    expected = directory.files
  #
  #
  #
  #    expect(expected.size).to eql 12
  #  end
  #
  #  it 'should combine directories and files' do
  #    directory = Directory.change_directory('Bob Dylan/Modern Times')
  #    expected = directory.content
  #
  #
  #
  #    expect(expected.size).to eql 13
  #  end
  #
  #end

  describe "tree maken" do
    before(:each) do
      @dir_path = 'child'
      @directory = Directory.new(@dir_path)
    end

    it 'should parse the root' do
      tree = Hash.new
      current_dir = ''
      @directory.to_tree2(["1subsub", "1other"], tree, current_dir)

      expect(tree.size).to eql 2
      tree.each do |t|
        puts t
      end
    end
    it 'should parse the child dir' do
      tree = Hash.new
      current_dir = '1child'
      @directory.to_tree2([current_dir, "#{current_dir}/2subsub", "#{current_dir}/2other"], tree, current_dir)

      expect(tree.size).to eql 3
      tree.each do |t|
        puts t
      end
    end
    it 'should parse the child child dir' do
      tree = Hash.new
      current_dir = '1child/2subchild'
      @directory.to_tree2([current_dir, "#{current_dir}/3subsub", "#{current_dir}/3other"], tree, current_dir)

      expect(tree.size).to eql 3
      tree.each do |t|
        puts t
      end


    end

  end
end