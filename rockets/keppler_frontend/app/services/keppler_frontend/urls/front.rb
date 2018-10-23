# frozen_string_literal: true

module KepplerFrontend
  module Urls
    # Assets
    class Front
      def initialize; end

      def view(name)
        "#{folder('view')}/#{name}.html.erb"
      end

      def layout
        "#{folder('layout')}/application.html.erb"
      end

      private

      def folder(folder_type)
        if folder_type.eql?('view')
          "#{root.rocket_root}/app/views/keppler_frontend/app/frontend"
        else
          "#{root.rocket_root}/app/views/layouts/keppler_frontend/app/layouts"
        end
      end

      def root
        KepplerFrontend::Urls::Roots.new
      end
    end
  end
end
