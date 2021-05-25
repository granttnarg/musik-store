class ApplicationController < ActionController::API
    
    DEFAULT_PAGINATION_LIMIT = 100

    def limit(value = DEFAULT_PAGINATION_LIMIT)
        # set our pagination limit to 100 or use input
        [ params.fetch(:limit, value).to_i, value ].min
    end

private

    def not_destroyed(error)
        render json: { errors: error.record.errors }, status: :unprocessable_entity
    end

    def handle_not_authorized
        render head :unauthorized
      end
      
    def not_found
        render status: :bad_request 
    end
end
