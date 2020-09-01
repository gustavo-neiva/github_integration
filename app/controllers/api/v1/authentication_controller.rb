module Api
  module V1
    class AuthenticationController < BaseController

      def create
        begin
          sign_in(email: params[:email], password: params[:password])
        rescue ActionDispatch::Http::Parameters::ParseError => e
          render json: { message: e.message }, status: :bad_request
        rescue RuntimeError => e
          render json: { errors: e.message }, status: :bad_request
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: "User not found." }, status: :not_found
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end

    end
  end
end