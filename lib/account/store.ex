defmodule Account.Store do
  use GenServer

  @moduledoc """
  The account store.
  """

  # Client API

  @doc """
  Start and link.
  """
  def start_link(_arg), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  @doc """
  Create a user.
  """
  def create(name, password, email), do: GenServer.call(__MODULE__, {:create, name, password, email})

  @doc """
  Read an account given its identifier.
  """
  def for_id(id), do: GenServer.call(__MODULE__, {:for_id, id})

  @doc """
  Read an account given its name.
  """
  def for_name(name), do: GenServer.call(__MODULE__, {:for_name, name})

  @doc """
  Read an account given its email address.
  """
  def for_email(email), do: GenServer.call(__MODULE__, {:for_email, email})

  @doc """
  Check an account's password.
  """
  def check_password(id, password), do: GenServer.call(__MODULE__, {:check_password, id, password})

  # Callbacks

  def init(_arg), do: {:ok, nil}

  def handle_call({:create, name, password, email}, _from, _data) do
    {:reply, Account.Access.create(name, password, email), nil}
  end
  def handle_call({:for_id, id}, _from, _data) do
    {:reply, Account.Access.read_for_id(id), nil}
  end
  def handle_call({:for_name, name}, _from, _data) do
    {:reply, Account.Access.read_for_name(name), nil}
  end
  def handle_call({:for_email, email}, _from, _data) do
    {:reply, Account.Access.read_for_email(email), nil}
  end
  def handle_call({:check_password, id, password}, _from, _data) do
    {:reply, Account.Access.check_password(id, password), nil}
  end
end
