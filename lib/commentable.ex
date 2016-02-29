defmodule Commentable do
  defdelegate comments_table_name(commenting_on), to: Commentable.Utils

  def comment_with(comment_module) do
    quote do
      Module.register_attribute(__MODULE__, :comment_module, accumulate: false)
      @comment_module unquote(comment_module)
      Module.register_attribute(__MODULE__, :comments_table, accumulate: false)
      @comments_table Commentable.comments_table_name(__MODULE__)
      use Commentable.Commented
    end
  end

  def acts_as_comment do
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

  defmacro __using__(name) when is_atom(name) do
    apply(__MODULE__, name, [])
  end

  defmacro __using__(options) do
    name = List.first Keyword.keys options
    option_value = Macro.expand(Keyword.get(options, name), __CALLER__)
    apply(__MODULE__, name, [option_value])
  end

end
