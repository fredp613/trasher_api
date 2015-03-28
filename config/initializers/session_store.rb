# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_trasher_session', domain: '.lvh.me'

Rails.application.config.session_store :cookie_store, key: '_trasher_session', domain: {
  production: 'trasher.herokuapp.com',
  development: '.me'
}.fetch(Rails.env.to_sym, :all)
