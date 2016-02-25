defmodule Commentable.Commented do
  defmacro __using__(_) do
    quote do
      import Commentable.Commented, only: [comments: 0]
      import Ecto.Query
      def comment_changeset(model, params \\ :empty) do
        model
        |> Ecto.Changeset.cast(params, ~w(), ~w())
        |> Ecto.Changeset.cast_assoc(:comments, required: true)
      end

      def comments_for(model) do
        from comment in Ecto.assoc(model, :comments)
      end
    end
  end

  defmacro comments do
    quote do
      if Module.get_attribute(__MODULE__, :comment_module) do
        has_many :comments, {@comments_table, @comment_module}, foreign_key: :commentable_id
      else
        raise "Please declare Commentable.comment_with <CommentModuleName> before including comments in the schema"
      end
    end
  end

end
