# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_trasher_session', domain: '.lvh.me'

Rails.application.config.session_store :cookie_store, key: '_trasher_session', domain: {
  production: 'trasher.herokuapp.com',
  development: 'lvh.me'
}.fetch(Rails.env.to_sym, :all)


# if Rails.env.production?

#   Rials.application.config.session_store :cookie_store, {:key => '_trasher_session', :domain => :all}

# else

#   Rails.application.config.session_store :cookie_store, :key => '_trasher_dev_session'

# end