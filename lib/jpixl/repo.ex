defmodule Jpixl.Repo do
  use Ecto.Repo,
    otp_app: :jpixl,
    adapter: Ecto.Adapters.Postgres
end
