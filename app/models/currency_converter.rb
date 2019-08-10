class CurrencyConverter
  extend Savon::Model
  client wsdl: "http://currencyconverter.kowabunga.net/converter.asmx?WSDL"

  def self.convertion_rate(currency_from, currency_to, rate_date = DateTime.now.strftime('%Y-%m-%d'))
    response = client.call(:get_conversion_rate, message: { 
      "CurrencyFrom" => currency_from,
      "CurrencyTo" => currency_to,
      "RateDate" => rate_date
    })
    if response.success?
      data = response.to_array(:get_conversion_rate_response).first
      if data
        data[:get_conversion_rate_result]
      end
    end
  end

  def self.currency_rates(rate_date = DateTime.now.strftime('%Y-%m-%d'))
    response = client.call(:get_currency_rates, message: { 
      "RateDate" => rate_date
    })
    if response.success?
      response.to_array(:get_currency_rates_response, :get_currency_rates_result, :diffgram, :new_data_set, :table)
    end
  end
end