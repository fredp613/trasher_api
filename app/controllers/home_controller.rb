class HomeController < ApplicationController

	skip_before_filter :authenticate_user!


def index 
	# cookies[:_cookietest_session] = {domain: '.lvh.me'}	
end

end