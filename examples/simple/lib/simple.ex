defmodule Simple.App do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    tree = [supervisor(Simple.Repo, [])]
    opts = [name: Simple.Sup, strategy: :one_for_one]
    Supervisor.start_link(tree, opts)
  end
end

defmodule Simple.Repo do
  use Ecto.Repo, otp_app: :simple
end

defmodule Comment do
  use Ecto.Schema
  require Commentable
  Commentable.acts_as_comment

  schema "abstract:comments" do
    comment_fields
  end
end

defmodule Article do
  use Ecto.Schema
  require Commentable
  Commentable.comment_with Comment

  schema "articles" do
    field :body
    comments
  end

  def changeset(model, params \\ :empty) do
    model
    |> Ecto.Changeset.cast(params, ~w(body), ~w())
  end

end

defmodule Image do
  use Ecto.Schema
  require Commentable
  Commentable.comment_with Comment

  schema "images" do
    field :url
    comments
  end

  def changeset(model, params \\ :empty) do
    model
    |> Ecto.Changeset.cast(params, ~w(url), ~w())
  end
end
