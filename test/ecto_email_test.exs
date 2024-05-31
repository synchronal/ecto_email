defmodule EctoEmailTest do
  # @related [subject](lib/ecto_email.ex)
  use Test.DataCase, async: true
  use EctoTemp, repo: Test.Repo

  require EctoTemp.Factory
  doctest EctoEmail

  deftemptable :has_emails_temp do
    column(:email, :string, null: false)
  end

  setup do
    create_temp_tables()
    :ok
  end

  defmodule HasEmails do
    use Ecto.Schema

    @primary_key false
    schema "has_emails_temp" do
      field(:email, EctoEmail)
    end

    def changeset(attrs), do: cast(%__MODULE__{}, Map.new(attrs), ~w[email]a)
  end

  test "can save a valid email" do
    assert {:ok, record} = HasEmails.changeset(email: "address@example.com") |> Test.Repo.insert()
    assert record.email == "address@example.com"
  end

  test "can load a valid email" do
    EctoTemp.Factory.insert(:has_emails_temp, email: "address@example.com")
    assert record = Test.Repo.get_by(HasEmails, email: "address@example.com")
    assert record.email == "address@example.com"
  end

  describe "cast" do
    test "requires a string" do
      assert {:ok, _} = EctoEmail.cast("a@example.com")
      assert {:error, message: "invalid email address"} = EctoEmail.cast(12)
      assert {:error, message: "invalid email address"} = EctoEmail.cast(12.0)
    end

    test "is invalid with an invalid email address string" do
      assert {:error, message: "malformed email address"} = EctoEmail.cast("alice.at.example.com")
    end

    test "validates the format of email addresses" do
      assert {:ok, _} = EctoEmail.cast(~s|simple@example.com|)
      assert {:ok, _} = EctoEmail.cast(~s|very.common@example.com|)
      assert {:ok, _} = EctoEmail.cast(~s|x@example.com|)
      assert {:ok, _} = EctoEmail.cast(~s|long.address-with-hyphens@and.subdomains.example.com|)
      assert {:ok, _} = EctoEmail.cast(~s|user.name+tag+sorting@example.com|)
      assert {:ok, _} = EctoEmail.cast(~s|name/surname@example.com|)
      assert {:ok, _} = EctoEmail.cast(~s|admin@example|)
      assert {:ok, _} = EctoEmail.cast(~s|example@s.example|)
      assert {:ok, _} = EctoEmail.cast(~s|" "@example.org|)
      assert {:ok, _} = EctoEmail.cast(~s|"john..doe"@example.org|)
      assert {:ok, _} = EctoEmail.cast(~s|mailhost!username@example.org|)
      assert {:ok, _} = EctoEmail.cast(~s|user%example.com@example.org|)
      assert {:ok, _} = EctoEmail.cast(~s|user-@example.org|)

      # invalid_email_addresses
      assert {:error, message: "malformed email address"} = EctoEmail.cast(~s|x|)
      assert {:error, message: "malformed email address"} = EctoEmail.cast(~s|abc.example.com|)
      assert {:error, message: "malformed email address"} = EctoEmail.cast(~s|a@b@c@example.com|)
      assert {:error, message: "malformed email address"} = EctoEmail.cast(~s|a"b(c)d,e:f;g<h>i[j\k]l@example.com|)
      assert {:error, message: "malformed email address"} = EctoEmail.cast(~s|just"not"right@example.com|)
      assert {:error, message: "malformed email address"} = EctoEmail.cast(~s|this is"not\allowed@example.com|)
      assert {:error, message: "malformed email address"} = EctoEmail.cast(~s|this\ still\"not\\allowed@example.com|)
      assert {:error, message: "malformed email address"} = EctoEmail.cast(~s|underscores@are_not_allowed_in_this_part|)

      assert {:error, message: "malformed email address"} =
               EctoEmail.cast(~s|1234567890123456789012345678901234567890123456789012345678901234+x@example.com|)
    end
  end

  describe "equal?" do
    test "is true when the addresses are the same" do
      assert "address@example.com" |> EctoEmail.equal?("address@example.com")
    end

    test "is true when the addresses have the same content but different case" do
      assert "AddreSS@example.COM" |> EctoEmail.equal?("address@example.com")
    end

    test "is false when the addresses are the same" do
      refute "address@example.com" |> EctoEmail.equal?("address2@example.com")
    end
  end
end
