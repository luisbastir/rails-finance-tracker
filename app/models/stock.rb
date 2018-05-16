class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  def self.new_from_lookup(ticket_symbol) 
    begin
      looked_up_stock = StockQuote::Stock.quote(ticket_symbol)
      new(name: looked_up_stock.company_name, ticket: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
    rescue => exception
      return nil
    end
  end

  def self.strip_commas(number)
    number.gsub(",", "")
  end

  def self.find_by_ticker(ticker_symbol)
    where(ticket: ticker_symbol).first
  end
end
