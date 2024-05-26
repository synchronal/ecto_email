# EctoEmail

TBD

## Installation

``` elixir
def deps do
  [
    {:ecto_email, "~> 0.1"}
  ]
end
```

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
