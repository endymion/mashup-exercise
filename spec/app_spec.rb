require 'spec_helper'

describe "The App" do

  it "should respond to GET" do
    get '/'
    last_response.should be_ok
    last_response.body.should match(/Vans Warped Tour Weather/)
    doc = Nokogiri::HTML(last_response.body)
    doc.css('h2').size.should == 5
  end

  it "should generate CSS from SASS" do
    get '/css/960.css'
    last_response.should be_ok
    last_response.body.should match(/body\s*\{[^\}]+\}/)
  end

end