use Mix.Config

# Do not print debug messages in production
config :logger, level: :info

config :logger,
  backends: [{LoggerFileBackend, :account_log}]

# Configure the account log back-end
config :logger, :account_log,
  path: "/var/log/backend/account.log"
