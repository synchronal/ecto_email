defmodule EctoEmail do
  # @related [test](test/ecto_email_test.exs)
  @moduledoc """
  An `Ecto.Type` for email addresses, using the
  [`:email_validator`](https://github.com/rbkmoney/email_validator) library
  for validations.

  ## Usage

  When creating an email field, the underline column  should be specified
  as a `:string` or a `:text`.

  ### Migration

  ``` elixir
  defmodule Core.Repo.Migrations.CreatePeople do
    use Ecto.Migration

    def change do
      create table(:people) do
        add :email_address, :string, null: false
        timestamps()
      end
    end
  end
  ```

  ### Schema

  The schema should specify the field as an `EctoEmail`. This will
  apply automatic validations to the field, though when accessing
  relevant structs the data will be returned as `String` values.

  ``` elixir
  defmodule Schema.Person do
    use Ecto.Schema
    import Ecto.Changeset

    schema "people" do
      field :email_address, EctoEmail
    end

    def changeset(data \\ %__MODULE__{}, attrs) do
      data
      |> cast(Map.new(attrs), ~w[email_address]a)
    end
  end
  ```

  ### Changesets

  Ecto changesets using the `Ecto.Enum` type will automatically validate
  the format of values.

  ``` elixir
  iex> assert Schema.Person.changeset(email_address: "a@b.com").valid?
  iex> assert changeset = Schema.Person.changeset(email_address: "a.at.b.com")
  iex> refute changeset.valid?
  iex> assert [email_address: {"malformed email address", _}] = changeset.errors
  ```
  """
  use Ecto.Type

  @doc """
  Callback implementation for `c:Ecto.Type.type/0`.

  Email address fields using `EctoEmail` should use a database column type
  capable of working with `:string` Ecto type. `:string`, `:text`, or `:citext`
  are examples of column types useable in migrations.
  """
  @impl Ecto.Type
  def type, do: :string

  @doc """
  Callback implementation for `c:Ecto.Type.cast/1`.

  Casts external input to a string, while validating that the format of the
  contents.

  ``` elixir
  iex> EctoEmail.cast("a@b.com")
  {:ok, "a@b.com"}
  iex> EctoEmail.cast("a+b@c.com")
  {:ok, "a+b@c.com"}

  iex> EctoEmail.cast("a.c.com")
  {:error, message: "malformed email address"}
  iex> EctoEmail.cast("12")
  {:error, message: "malformed email address"}
  iex> EctoEmail.cast(12)
  {:error, message: "invalid email address"}

  iex> assert %Ecto.Changeset{valid?: true} = Schema.Person.changeset(email_address: "a@b.com")
  iex> assert %Ecto.Changeset{valid?: false} = Schema.Person.changeset(email_address: "a.b.com")
  ```
  """
  @impl Ecto.Type
  def cast(address) when is_binary(address) do
    if :email_validator.validate(address) == :ok do
      {:ok, address}
    else
      {:error, message: "malformed email address"}
    end
  end

  def cast(_), do: {:error, message: "invalid email address"}

  @doc """
  Callback implementation for `c:Ecto.Type.equal?/2`.

  ``` elixir
  iex> assert EctoEmail.equal?("a@b.com", "a@b.com")
  iex> refute EctoEmail.equal?("a@b.com", "a@c.com")
  ```
  """
  @impl Ecto.Type
  def equal?(address, address) when is_binary(address), do: true
  def equal?(left, right) when is_binary(left) and is_binary(right), do: String.downcase(left) == String.downcase(right)
  def equal?(_, _), do: false

  @doc "Callback implementation for `c:Ecto.Type.load/1`"
  @impl Ecto.Type
  def load(address) when is_binary(address), do: {:ok, address}
  def load(_), do: :error

  @doc "Callback implementation for `c:Ecto.Type.dump/1`"
  @impl Ecto.Type
  def dump(address) when is_binary(address), do: {:ok, address}
  def dump(_), do: :error
end
