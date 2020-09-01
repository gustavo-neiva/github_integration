module Api
  module V1
    class SearchRepositoriesController < BaseController

      before_action :authorize_request

      def index
        begin
          use_case = UseCases::SearchQueryRepositories.build
          repositories_response = use_case.execute(params: repository_params.to_hash)
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
        params.permit(:q, :sort, :order, :page, :per_page)
      end

      def render_error(e, status = :bad_request)
        render json: { error: e, message: e.message }, status: status
      end

    end
  end
end