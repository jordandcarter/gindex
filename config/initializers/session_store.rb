# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gIndex_session',
  :secret      => 'c41614b14ae00896c0ec4e68b0e19ebe7bf13373c7be8d7840bd9d434da37fc8adab6d0f88cee452b23e080a2e14e099660239e42e54d1b2ac24de1d5585bc85'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
