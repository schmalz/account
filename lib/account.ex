defmodule Account do

  @moduledoc """
  Access to accounts.

  Accounts have an identifier (a UUID assigned by the system on creation), a name (unique amongst all accounts) and
  password, an email address (also unique amongst all accounts), etc.
  """

  @doc """
  Create an account from initial data.

  Returns `{:ok, <identifier>}` on success, {:error, <reason>}` otherwise.
  """
  @spec create(String.t, String.t, String.t) :: {:ok, String.t} | {:error, String.t}
  def create(name, password, email), do: Account.Store.create(name, password, email)

  @doc """
  Read an account given its identifier.

  Returns `{:ok, <account>}` on success, {:error, <reason>}` otherwise.
  """
  def for_id(id), do: Account.Store.for_id(id)

  @doc """
  Read an account given its name.

  Returns `{:ok, <account>}` on success, {:error, <reason>}` otherwise.
  """
  def for_name(name), do: Account.Store.for_name(name)

  @doc """
  Read an account given its email address.

  Returns `{:ok, <account>}` on success, {:error, <reason>}` otherwise.
  """
  def for_email(email), do: Account.Store.for_email(email)

  @doc """
  Check an account's password.
  """
  def check_password(id, password), do: Account.Store.check_password(id, password)
end
