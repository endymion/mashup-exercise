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
    last_date.city.should == 'Portland, OR'
  end

end