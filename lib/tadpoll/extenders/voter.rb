module Tadpoll
  module Extenders
    module Voter

      def voter?
        false
      end

      def is_voter(*args)
        require 'tadpoll/voter'
        include Tadpoll::Voter

        class_eval do
          def self.voter?
            true
          end
        end
      end

    end
  end
end