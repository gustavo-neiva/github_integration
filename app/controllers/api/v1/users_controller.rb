module Api
  module V1
    class UsersController < BaseController
      before_action :authorize_request, except: :create
      before_action :find_user, except: :create

      def show
        render json: @user, status: :ok
      end

      def create
        begin
          @user = User.new(user_params)
          if @user.save!
            render json: { message: "User #{@user.email} created." }, status: :created
          else
            render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
          end
        rescue ActiveRecord::RecordInvalid => error
          render json: { message: error }, status: :conflict
        rescue RuntimeError => error
          render json: { message: error }, status: :bad_request
        end
      end

      def update
        unless @user.update!(user_params)
          render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @user.destroy!
          render json: { message: 'User deleted.' }, status: :ok
        end
      end

      private

      def find_user
        begin
          @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { message: 'User not found' }, status: :not_found
        end
      end

      def user_params
        params.require(:user).permit(:name, :username, :email, :password, :id)
      end
    end
  end
end
