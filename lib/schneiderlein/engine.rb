# frozen_string_literal: true
module Schneiderlein
  class Engine < ::Rails::Engine
    isolate_namespace Schneiderlein

    initializer 'schneiderlein.middleware' do |app|
      if Rails::VERSION::MAJOR < 5
        app.config.middleware.insert_before \
          'ActionDispatch::ParamsParser', 'Schneiderlein::FlyCatcher'
      else
        # ActionDispatch::ParamsParser is not included in the middleware
        # stack anymore in Rails 5.
        app.config.middleware.insert_after \
          'ActionDispatch::Callbacks', 'Schneiderlein::FlyCatcher'
      end
    end
  end

end
