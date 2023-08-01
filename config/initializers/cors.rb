Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins 'localhost:5173', 'https://main.d1r7v6lmapahca.amplifyapp.com', 'https://reyaly-financial-planner.netlify.app'
      resource '*',
        headers: :any,
        methods: %i(get post put patch delete options head)
    end
  end