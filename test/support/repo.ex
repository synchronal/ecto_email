defmodule Test.Repo do
  use Ecto.Repo, otp_app: :ecto_email, adapter: Ecto.Adapters.Postgres
end
