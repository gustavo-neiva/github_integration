module Api
  module V1
    class UserRepositoriesController < BaseController
      before_action :authorize_request

      def index
        begin
          use_case = UseCases::SearchUsersRepositories.build
          repositories_response = use_case.execute(user: repository_params[:username], page: repository_params[:page])
          response.headers["link"] = repositories_response.links
          render json: repositories_response.body, status: :ok
        rescue Exceptions::TimeOutException => e
          render_error(e, e.status)
        rescue Exceptions::UnauthorizedException => e
          render_error(e, e.status)
        rescue Exceptions::NotFoundException => e
          render_error(e, e.status)
        rescue Exception => e
          render_error(e)
        end
      end

      private

      def repository_params
        params.permit(:username, :page)
      end


      def render_error(e, status = :bad_request)
        render json: { error: e, message: e.message }, status: status
      end

    end
  end
end