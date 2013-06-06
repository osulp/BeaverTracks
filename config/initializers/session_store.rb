# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Beaver-Tracks_session',
  :secret      => '7f40effed9bb80e449c453edc5f4d095a0fb9d68f43b1034f4709310a97d775f406fb803feb4d977de151195e3e50f10b674fee2aabf011ddcd35022ab1868c9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
