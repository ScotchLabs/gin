# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_git_session',
  :secret      => 'a574464b1f74792d62b84a6fdf16e931314bba71e6f94e07d503724298938a2f8f79dde1c8f14b648f32ccb609aa92e2ed2db05f64a6c1182973d5441a9b8aee'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
#
ActionMailer::Base.smtp_settings = {:enable_starttls_auto => false}
