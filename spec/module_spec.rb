# Simple example of using ShadowFacter with RSpec to verify system configuration
# bradley @ http://railsmachine.com
#
# run with 'spec -c installed_test.rb'

require File.join(File.dirname(__FILE__), "../lib",'facts.rb')

describe "My rails machine" do
  
  before :each do
    @installed = facts(:installed)
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
  
  it "has passenger gem installed and available" do
    @installed[:passenger_gem].should equal(true)
  end
  
end