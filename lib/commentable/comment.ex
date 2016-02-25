defmodule Commentable.Comment do
  defmacro __using__(_) do
    quote do
      import Commentable.Comment, only: [comment_fields: 0]

      def changeset(model, params \\ :empty) do
        model
        |> Ecto.Changeset.cast(params, ~w(comment), ~w())
        |> Ecto.Changeset.foreign_key_constraint(:commentable_id)
      end

      defoverridable [changeset: 2]
    end
  end

  defmacro comment_fields do
    quote do
      field :commentable_id, :integer
      field :comment
    end
  end
end
