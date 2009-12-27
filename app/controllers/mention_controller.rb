class MentionController < ApplicationController
  def index
      if current_user.nil?
      redirect_to login_path
    end
  end
end
