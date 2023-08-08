require "httparty"
require "json"

class ConverterController < ApplicationController

    # GET /converter or /converter.json
    def index
      puts params
      puts ENV["NINJA_API_KEY"]
      puts "hello"

      if params[:have] && params[:want] && params[:amount]

        converter_url = "https://api.api-ninjas.com/v1/convertcurrency?"
        con_parameters = "have=#{params[:have]}&want=#{params[:want]}&amount=#{params[:amount]}"
        puts converter_url + con_parameters
        con_response = HTTParty.get(converter_url + con_parameters, { 
          headers: { 
            "X-Api-Key" => ENV["CONVERTER_API_KEY"]
          }, 
        }) 
        puts con_response.body

        exchange_url = "https://api.api-ninjas.com/v1/exchangerate?"
        ex_parameters = "pair=#{params[:have]}_#{params[:want]}"
        puts exchange_url + ex_parameters
        ex_response = HTTParty.get(exchange_url + ex_parameters, { 
          headers: { 
            "X-Api-Key" => ENV["NINJA_API_KEY"]
          }, 
        }) 
        puts ex_response.body

        data = {conversion: JSON.parse(con_response.body), exchange: JSON.parse(ex_response.body)}
        render json: { data: data, status: :ok}, status: :ok
      else
        render json: { message: "Missing required information", status: :unprocessable_entity }, status: :unprocessable_entity 
      end

    end

end
