require 'spec_helper'
require_relative '../tourdate'

describe "TourDate" do

  it "should extract tour dates from web page" do
    FakeWeb.register_uri(:get, 'http://vanswarpedtour.com/dates',
      :body => File.open('spec/fixtures/dates.html'))
    dates = TourDate.get_dates
    dates.size.should == 5
    last_date = dates.last
    last_date.date.should == 'Aug 05 2012'
    last_date.city.should == 'Portland'
    last_date.state.should == 'OR'
  end

  it "should get the current weather for a given date" do
    FakeWeb.register_uri(:get,
      'http://www.wunderground.com/cgi-bin/findweather/hdfForecast?query=Portland,%20OR',
      :body => File.open('spec/fixtures/weather.html'))

    date = TourDate.new(:city => 'Portland', :state => 'OR')
    date.get_weather
    date.conditions.should == 'Overcast'
    date.temperature.should match /48\.9/
  end

end