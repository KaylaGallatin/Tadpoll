module Tadpoll
  module Extenders

    module Controller

      def voter_params(params_object = params[:vote])
        params_object.permit(:voter_id, :voter_type)
      end
      
    end
  end
end