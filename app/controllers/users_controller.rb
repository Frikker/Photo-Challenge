class UsersController < InheritedResources::Base

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :provider, :url)
    end

end
