require 'spec_helper'
require_relative '../event'

describe "Event" do

  it "should extract tour dates from web page" do
    FakeWeb.register_uri(:get, 'http://vanswarpedtour.com/dates',
      :body => File.open('spec/fixtures/dates.html'))
    events = Event.get_events
    events.size.should == 5
    last_event = events.last
    last_event.date.should == 'Aug 05 2012'
    last_event.city.should == 'Portland'
    last_event.state.should == 'OR'
  end

  it "should get the current weather for a given date" do
    FakeWeb.register_uri(:get,
      'http://www.wunderground.com/cgi-bin/findweather/hdfForecast?query=Portland,%20OR',
      :body => File.open('spec/fixtures/weather.html'))

    event = Event.new(:city => 'Portland', :state => 'OR')
    event.get_weather
    event.conditions.should == 'Overcast'
    event.temperature.should match /48\.9/
  end

end