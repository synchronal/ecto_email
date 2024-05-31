defmodule Schema.Person do
  @moduledoc false
  use Ecto.Schema

  schema "people" do
    field(:email_address, EctoEmail)
  end

  def changeset(data \\ %__MODULE__{}, attrs) do
    data
    |> Ecto.Changeset.cast(Map.new(attrs), ~w[email_address]a)
  end
end
