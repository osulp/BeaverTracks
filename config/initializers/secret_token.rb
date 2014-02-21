# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Beavertracks::Application.config.secret_token = '6d40266e208fb6ba1f7ffdc76f3c29f7b9d1c4fdd9d05d7687f34ac6bc0143afce7ee9f9f64adaccd6a565e509ebc4708e30928bded6feb06bda912813fcf0d6'
Beavertracks::Application.config.secret_key_base = ENV['BEAVERTRACKS_SECRET_KEY']
