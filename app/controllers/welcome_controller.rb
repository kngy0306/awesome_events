class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    # @events = Event.page(params[:page]).per(10).where("start_at > ?", Time.zone.now).order(:start_at)
    @events = Event.page(params[:page]).per(10).order(:start_at) # 過ぎた日程のイベントでも表示する
    @current_user = current_user
  end
end
