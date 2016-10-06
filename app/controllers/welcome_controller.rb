class WelcomeController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:index, :about, :contact]
  def index
  end

  def about
  end

  def contact
  end
end
