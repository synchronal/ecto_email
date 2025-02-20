## Change log

## Unreleased

- Require `ExEmail` version greater than or equal to v0.1.2.

## 3.0.1

- Replace `:email_validator` with `ExEmail`.

## 3.0.0

- Test against Elixir 1.18.
- **Breaking change:** drop support for Elixir 1.15.

## 2.0.0

- Email addresses with different cases are considered equal.
- **Breaking change:** Use `EctoEmail` instead of `Ecto.Email`.

## 1.0.0

- Initial release.
- Adds `Ecto.Email` type for schemas with email address fields.
