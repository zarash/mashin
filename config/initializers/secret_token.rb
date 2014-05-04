# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Mashin::Application.config.secret_key_base = ENV['SECRET_TOKEN']

# '444fbbcc34ac3c6ee0941c17da29a4386f0ef3f5eee3257ffa1cb1f2431e7db9dc9b418b2affc7dd2931ebee01d07ac3e3113445ab49dc1742a5d457e46e662e'
