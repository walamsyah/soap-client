require 'savon'

class ConversionRateService
  attr_reader :rate_result

  def initialize(currency_from, currency_to, rate_date = DateTime.now.strftime('%Y-%m-%d'))
    # Gyoku.convert_symbols_to :camelcase
    # client = Savon::Client.new("http://currencyconverter.kowabunga.net/converter.asmx?WSDL")
    client = Savon.client(wsdl: "http://currencyconverter.kowabunga.net/converter.asmx?WSDL")
    response = client.call(:get_conversion_rate, message: { 
      "CurrencyFrom" => currency_from,
      "CurrencyTo" => currency_to,
      "RateDate" => rate_date
    })
    if response.success?
      data = response.to_array(:get_conversion_rate_response).first
      if data
        @rate_result = data[:get_conversion_rate_result]
      end
    end
  end
end