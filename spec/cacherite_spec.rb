require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Cacherite do
  before do
    @directory = File.join(File.dirname(__FILE__), "tmp")
    @cr = Cacherite.new(@directory)
    @cr.clean
  end

  it "set lifetime" do
    @cr.lifetime = 60
  end

  it "get cache as nil" do
    @cr.get("key").should be_nil
  end

  it "caching" do
    @cr.save("key", "content")
  end

  it "hit cache" do
    @cr.save("key", "content")
    @cr.get("key").should eq "content"
  end

  it "missing cache" do
    @cr.save("key", "content")
    @cr.lifetime = 1
    sleep 1
    @cr.get("key").should be_nil
    @cr.lifetime = 3600
  end

  it "cache remove" do
    @cr.save("key", "content")
    @cr.remove("key")
    @cr.get("key").should be_nil
  end

  it "cache clean" do
    @cr.save("key", "content")
    @cr.clean
    @cr.get("key").should be_nil
  end

  it "extend life" do
    @cr.save("key", "content")
    old = File.mtime(File.join(@directory, "key"))
    @cr.get("key")
    sleep 1
    @cr.extend_life().should_not be_false
    new = File.mtime(File.join(@directory, "key"))
    (new - old).should eq 1
  end

  it "get path" do
    @cr.save("key", "content")
    @cr.get_path("key").should eq File.join(@directory, "key")
  end
end
