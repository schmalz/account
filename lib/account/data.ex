use Amnesia

defdatabase Accounts do
  deftable Account, [:id, :name, :email, :created], type: :set, index: [:name, :email] do
    @type t :: %Account{id: String.t, name: String.t, email: String.t, created: DateTime.t}
  end
  deftable AccountPassword, [:id, :password_hash], type: :set do
    @type t :: %AccountPassword{id: String.t, password_hash: String.t}
  end
end
