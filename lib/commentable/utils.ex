defmodule Commentable.Utils do
  def comments_table_name(commenting_on_module) do
    (commenting_on_module
     |> to_string
     |> String.split(".")
     |> List.last
     |> Mix.Utils.underscore)
     <> "_comments"
  end
end
