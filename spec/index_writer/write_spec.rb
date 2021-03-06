require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexWriter#write" do
  before do
    @path = prepare_index_dir
  end

  it "sets count to 0" do
    w = Polecat::IndexWriter.new @path
    w.add Spec::TestDocument.new
    w.write
    w.count.should == 0
  end

  it "returns true when the write was a success" do
    w = Polecat::IndexWriter.new @path
    w.add Spec::TestDocument.new
    w.write.should == true
  end

  it "removes the lock after a write" do
    w = Polecat::IndexWriter.new @path
    w.add Spec::TestDocument.new
    w.write
    File.exists?(@path + '/index.lock').should == false
  end

  it "takes a higher number for the index file, if there is already one" do
    FileUtils.touch @path + '/ind0.ind'
    w = Polecat::IndexWriter.new @path
    w.add Spec::TestDocument.new
    w.write
    File.exists?(@path + '/ind1.ind').should == true
  end

  it "writes a marshalled representation of the document list" do
    w = Polecat::IndexWriter.new @path
    doc = Spec::TestDocument.new
    w.add doc
    w.write
    File.read(@path + '/ind0.ind').should == Marshal.dump([doc])
  end

  it "returns false when the directory has an 'index.lock' file" do
    w = Polecat::IndexWriter.new @path
    FileUtils.touch @path + '/index.lock'
    w.add Spec::TestDocument.new
    w.write.should == false
  end
end
