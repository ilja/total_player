module OmniAuth
  module Strategies
    class Identity
      # Disable registrations
      def registration_phase
      end

      def registration_form
        redirect "/auth/identity"
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, :fields => [:email]
end