class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def edit
    current_user.create_profile unless current_user.profile
  end

  def update
    if current_user.update(params.require(:user).permit(profile_attributes: [:id, :legal_name, :birthday, :location, :education, :occupation, :bio, :specialty]))
      flash[:notice] = "updated successfully"
      redirect_to user_path
    else
      render :new
    end
  end
end
