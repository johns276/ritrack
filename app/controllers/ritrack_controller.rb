class RitrackController < ApplicationController
  skip_before_action :authorize

  layout 'application'

  def index

  end

end
