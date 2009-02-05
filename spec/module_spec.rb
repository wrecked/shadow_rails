# Simple example of using ShadowFacter with RSpec to verify system configuration
# bradley @ http://railsmachine.com
#
# run with 'spec -c installed_test.rb'

require File.join(File.dirname(__FILE__), 'facts.rb')

describe "My system" do
  
  before :each do
    @installed = facts(:installed)
  end
  
  it "has gcc installed and available" do
    @installed[:gcc].should equal(true)
  end
  
  it "has ruby on rails installed and available" do
    @installed[:rails].should equal(true)
  end
  
  it "has mysql installed and available" do
    @installed[:mysql].should equal(true)
  end
  
  it "has mysql gem installed and available" do
    @installed[:mysql_gem].should equal(true)
  end
  
  it "has mysql gem installed and available" do
    @installed[:shadow_puppet_gem].should equal(true)
  end
  
  it "has git installed and available" do
    @installed[:git].should equal(true)
  end
  
  it "has puppet installed and available" do
    @installed[:puppet].should equal(true)
  end
  
  it "has ruby gems installed and available" do
    @installed[:gem].should equal(true)
  end
  
end