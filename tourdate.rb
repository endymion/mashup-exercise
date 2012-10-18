require 'nokogiri'

class TourDate
  attr_accessor :date
  attr_accessor :city

  def initialize(params)
    self.date = params[:date]
    self.city = params[:city]
  end

  def self.get_dates
    doc = Nokogiri::HTML(Net::HTTP.get('vanswarpedtour.com', '/dates'))
    (
      doc.css('.events .event-row').map do |event|
        TourDate.new(
          :date => event.at_css('.date').text,
          :city => event.at_css('.location').to_xml.match(/\<br\/\>\s*([^\<]+)\<div/)[1]
        )
      end
    ).slice(-5, 5)
  end

end