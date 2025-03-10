# EctoEmail

[![CI](https://github.com/synchronal/ecto_date_time_range/actions/workflows/tests.yml/badge.svg)](https://github.com/synchronal/ecto_date_time_range/actions)
[![Hex
pm](http://img.shields.io/hexpm/v/ecto_date_time_range.svg?style=flat)](https://hex.pm/packages/ecto_date_time_range)

An `Ecto.Type` for email addresses, using the
[`ex_email`](https://github.com/synchronal/ex_email) library for
validations. When using a database column type interchangeable with
`:string` such as `:text`, `:string`, or `:citext`, this type may be
used in the schema module to provide automatic validation of inputs.

- Repo: <https://github.com/synchronal/ecto_email>
- Hex docs: <https://hexdocs.pm/ecto_email>

Our open source `Ecto.Type` libraries:

- [ecto_date_time_range](https://github.com/synchronal/ecto_date_time_range)
- [ecto_email](https://github.com/synchronal/ecto_email)
- [ecto_phone](https://github.com/synchronal/ecto_phone)

This library is tested against the most recent 3 versions of Elixir and
Erlang.

## Sponsorship 💕

This library is part of the [Synchronal suite of libraries and
tools](https://github.com/synchronal) which includes more than 15 open
source Elixir libraries as well as some Rust libraries and tools.

You can support our open source work by [sponsoring
us](https://github.com/sponsors/reflective-dev). If you have specific
features in mind, bugs you'd like fixed, or new libraries you'd like to
see, file an issue or contact us at
[<contact@reflective.dev>](mailto:contact@reflective.dev).

## Installation

``` elixir
def deps do
  [
    {:ecto_email, "~> 1.0"}
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
