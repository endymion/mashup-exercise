require 'nokogiri'
require 'open-uri'
require 'net/http'

class TourDate
  attr_accessor :date
  attr_accessor :city
  attr_accessor :state
  attr_accessor :conditions
  attr_accessor :temperature

  def initialize(params)
    self.date = params[:date]
    self.city = params[:city]
    self.state = params[:state]
  end

  def self.get_dates
    doc = Nokogiri::HTML(Net::HTTP.get('vanswarpedtour.com', '/dates'))
    (
      doc.css('.events .event-row').map do |event|
        TourDate.new(
          :date => event.at_css('.date').text,
          :city => event.at_css('.location').to_xml.match(/\<br\/\>\s*([^\,]+)\,/)[1],
          :state => event.at_css('.location').to_xml.match(/\<br\/\>.*\,\s*([^\<]+)\<div/)[1]
        )
      end
    ).slice(-5, 5)
  end

  def get_weather
    doc = Nokogiri::HTML(Net::HTTP.get("www.wunderground.com",
      "/cgi-bin/findweather/hdfForecast?query=#{URI::encode(city + ', ' + state)}"))
    self.conditions = doc.css('#curCond').text
    self.temperature = doc.css('#tempActual').text.strip
  end

end