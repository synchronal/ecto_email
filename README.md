# EctoEmail

This library provides an `Ecto.Type` in the guise of `EctoEmail`. When
using a database column type interchangeable with `:string` such as
`:text`, `:string`, or `:citext`, this type may be used in the schema
module to provide automatic validation of inputs.

This library is tested against the most recent 3 versions of Elixir and
Erlang.

## Installation

``` elixir
def deps do
  [
    {:ecto_email, "~> 2.1"}
  ]
end
```

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

See the [documentation](https://hexdocs.pm/ecto_email) for more info.

## Development

This project uses [medic](https://github.com/synchronal/medic-rs) for
its development workflow.

``` shell
brew bundle

bin/dev/doctor
bin/dev/test
bin/dev/audit
bin/dev/update
bin/dev/shipit
```

Please take a look at `.config/medic.toml` for the checks that must pass
in order for changes to be accepted.
