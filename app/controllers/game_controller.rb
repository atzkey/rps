class GameController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :define_rules

  def create
    curb_throw = CurbThrow.new.call
    
    render json: {
      result: Rps.new(@rules).match(params[:throw], curb_throw),
      player_throw: params[:throw],
      curb_throw: curb_throw
    }
  end

  private
  def define_rules
    @rules =
      if Rails.configuration.respond_to? :rps_rules
        Rails.configuration.rps_rules
      else
        Rps::DEFAULT_RULES
      end
  end
end
