require "httparty"
require "nokogiri"

class SavingsController < ApplicationController

  SavingsAccount = Struct.new('SavingsAccount', :name, :rate, :percentage, :min, :link) 

  # GET /savings or /savings.json
  def index
    savings_accounts = [] 
    
    url = "https://www.nerdwallet.com/best/banking/savings-rates"

    response = HTTParty.get(url, { 
      headers: { 
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36" 
      }, 
    }) 
      
    document = Nokogiri::HTML(response.body)

    date_fetched = document.css("time").first.text

    html_products = document.css("tr")
    
    html_products.slice(1, html_products.length).each do |html_product| 

      name = html_product.css("td > p").first.text
      rate = html_product.css("td:nth-child(3) > div").first.text
      min = html_product.css("td:nth-child(3) > div").last.text
      link = html_product.css("td > a").first.attribute("href").value 

      rate_percent = rate[0..rate.index("%") -1].to_f

      dollar_sign = min.index("$") 
      end_space = min[dollar_sign..-1].index(" ") + dollar_sign - 1
      dollar_amount = min[dollar_sign..end_space]

      savings_account = SavingsAccount.new(name, rate, rate_percent, dollar_amount, link) 
  
      savings_accounts.push(savings_account) 
    end 

    render json: { data: savings_accounts, fetched: date_fetched, status: :ok} 
  end

end
