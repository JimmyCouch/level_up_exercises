# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra/base'

class Overlord < Sinatra::Base

	use Rack::Session::Pool, :expire_after => 2592000

	get '/' do
		session[:bomb_status] = false

		if bomb_status
			erb :active, :layout => :index
		else
			erb :inactive, :layout => :index
		end
	end

	post '/submit-activation-form' do
	    code = @params[:code]
	    if !validate_form(code)
	    else
	    end
	    redirect '/'
	end

	def validate_form(code)
		code =~ /\d/
	end

	def bomb_status
		session[:bomb_status]
	end

	def start_time
	  session[:start_time] ||= (Time.now).to_s
	end
end

Overlord.run! if ENV['RACK_ENV'] != 'test'