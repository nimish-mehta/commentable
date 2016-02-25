defmodule Commentable do
  defdelegate comments_table_name(commenting_on), to: Commentable.Utils

  defmacro comment_with(comment_module) do
    quote do
      Module.register_attribute(__MODULE__, :comment_module, accumulate: false)
      @comment_module unquote(comment_module)
      Module.register_attribute(__MODULE__, :comments_table, accumulate: false)
      @comments_table Commentable.comments_table_name(__MODULE__)
      use Commentable.Commented
    end
  end

  defmacro acts_as_comment do
    quote do
      use Commentable.Comment
    end
  end


  defmacro comment_columns(commenting_on) do
    expanded = Macro.expand(commenting_on, __CALLER__)
    reference_table = String.to_atom expanded.__schema__(:source)
    quote do
      add :commentable_id, references(unquote(reference_table))
      add :comment, :string
    end
  end

end
