module Schneiderlein
  class Engine < ::Rails::Engine
    isolate_namespace Schneiderlein

    initializer 'schneiderlein.middleware' do |app|
      app.config.middleware.insert_before \
        'ActionDispatch::ParamsParser', 'Schneiderlein::FlyCatcher'
    end
  end

end
