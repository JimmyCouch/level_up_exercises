# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra/base'
require 'rack-flash'

class Overlord < Sinatra::Base

	use Rack::Session::Pool, :expire_after => 2592000
	use Rack::Flash

	get '/' do
		session[:bomb_status] ||= false
		session[:bomb_deactivation_count] ||= 0
		session[:bomb_timer] ||= 15000
		if bomb_status 
			erb :active, :layout => :index
		else
			erb :inactive, :layout => :index
		end
	end

	get '/cut-wire' do
		if [true, false].sample
			session[:bomb_status] = false
			flash[:success] ="Success: You got lucky!"
		else
			explode_this_bitch
		end	
		redirect('/')
	end

	get '/explode' do
		session[:bomb_status] = false
		session[:bomb_timer] = nil
		session[:bomb_deactivation_count] = 0
		erb :explode
	end

	post '/submit-activation-form' do
	    if validate_form(@params[:code])
	    	session[:bomb_status] = true
	    	session[:bomb_timer] = nil
			session[:bomb_deactivation_count] = 0
			flash[:danger] ="Success: The bomb has been activated"
	    else
			flash[:danger] ="Error: Please enter only numbers"
	    end
	    redirect '/'
	end

	post '/submit-deactivation-form' do

		session[:bomb_timer] = (@params[:timer].split(":"))[1].to_i * 1000

	    if validate_form(@params[:code])
	    	session[:bomb_status] = false
			flash[:success] ="Success: The bomb has been deactivated"
	    else
	    	if (session[:bomb_deactivation_count] += 1) >= 3
	    		explode_this_bitch
	    	end
			flash[:danger] ="Error: Incorrect input, only #{3 - session[:bomb_deactivation_count]} attempts left"
	    end
	    redirect '/'
	end

	def explode_this_bitch
		session[:is_exploded] = true
		session[:bomb_status] = false
		redirect ('/explode')
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

	helpers do
	  def flash_types
	    [:success, :notice, :warning, :danger]
	  end
	end

end

Overlord.run! if ENV['RACK_ENV'] != 'test'