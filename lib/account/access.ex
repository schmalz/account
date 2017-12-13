defmodule Account.Access do
  use Amnesia

  @moduledoc """
  Access to account data, stored as records in Amnesia.
  """

  def create(name, password, email) do
    Amnesia.transaction do
      case Amnesia.Table.read_at(Accounts.Account, name, :name) do
        nil ->
          case Amnesia.Table.read_at(Accounts.Account, email, :email) do
            nil ->
              write_account(name, password, email)
            _ ->
              {:error, "email already in use"}
          end
        _ ->
          {:error, "name already in use"}
      end
    end
  end

  def read_for_id(id) do
    Amnesia.transaction do
      case Amnesia.Table.read(Accounts.Account, id) do
        [account] ->
          {:ok, from_record(account)}
        nil ->
          {:error, "account does not exist"}
      end
    end
  end

  def read_for_name(name) do
    Amnesia.transaction do
      case Amnesia.Table.read_at(Accounts.Account, name, :name) do
        [account] ->
          {:ok, from_record(account)}
        nil ->
          {:error, "name does not exist"}
      end
    end
  end

  def read_for_email(email) do
    Amnesia.transaction do
      case Amnesia.Table.read_at(Accounts.Account, email, :email) do
        [account] ->
          {:ok, from_record(account)}
        nil ->
          {:error, "email does not exist"}
      end
    end
  end

  def check_password(id, password) do
    Amnesia.transaction do
      case Amnesia.Table.read(Accounts.AccountPassword, id) do
        [{Accounts.AccountPassword, ^id, hash}] ->
          {:ok, Comeonin.Argon2.checkpw(password, hash)}
        nil ->
          {:error, "account does not exist"}
      end
    end
  end

  defp write_account(name, password, email) do
    id = UUID.uuid4()
    %Accounts.Account{id: id, name: name, email: email, created: DateTime.utc_now()}
    |> Accounts.Account.write
    %{password_hash: hash} = Comeonin.Argon2.add_hash(password)
    %Accounts.AccountPassword{id: id, password_hash: hash}
    |> Accounts.AccountPassword.write
    {:ok, id}
  end

  defp from_record({Accounts.Account, id, name, email, created}) do
    %Accounts.Account{id: id, name: name, email: email, created: created}
  end
end
