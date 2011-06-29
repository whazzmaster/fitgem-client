require 'fitbit_client_wrapper'

class FitgemOauthController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  def start
    client = Fitgem::Client.new({:consumer_key => APP_CONFIG[:fitbit_consumer_key], :consumer_secret => APP_CONFIG[:fitbit_consumer_secret]})
    request_token = client.request_token
    current_user.fitbit_account.set_request_token!(request_token.token, request_token.secret)
    token = current_user.fitbit_account.request_token

    redirect_to "http://www.fitbit.com/oauth/authorize?oauth_token=#{token}"
  end

  def verify
    if params[:oauth_token] && params[:oauth_verifier]
      @client = Fitgem::Client.new({:consumer_key => APP_CONFIG[:fitbit_consumer_key], :consumer_secret => APP_CONFIG[:fitbit_consumer_secret], :user_id => '-'})
      fitbit_account = current_user.fitbit_account
      token = params[:oauth_token]
      secret = fitbit_account.request_secret
      verifier = params[:oauth_verifier]
      begin
        access_token = @client.authorize(token, secret, { :oauth_verifier => verifier })
      rescue
        flash[:alert] = "Oops, there wasn't a valid OAuth session on Fitbit. Try to authorize again."
        redirect_to fitbit_index_path and return
      end
      fitbit_account.verify!(access_token.token, access_token.secret, verifier)
      @info = @client.user_info['user']
    else
      flash[:alert] = 'Could not verify your account with Fitbit'
      redirect_to root_url
    end
  end
  
  def info
    unless current_user.fitbit_account.verified?
      flash[:alert] = "Your test account is not connected to a Fitbit account. "
      redirect_to :action => :index and return
    end
    client = FitgemClientWrapper.new(current_user.fitbit_account)
    @info = client.user_info['user']
  end
  
  def disconnect
    current_user.fitbit_account.clear!
    flash[:notice] = "Your test account has been disconnected from your Fitbit account"
    redirect_to root_url
  end

end
