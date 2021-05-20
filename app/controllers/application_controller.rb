class ApplicationController < ActionController::API

private
    def not_destroyed(error)
        render json: { errors: error.record.errors }, status: :unprocessable_entity
    end
end
