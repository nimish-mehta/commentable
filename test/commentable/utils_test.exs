defmodule Commentable.UtilsTest do
  use ExUnit.Case

  test "comments_table_name/1 with No Nesting" do
    assert Commentable.Utils.comments_table_name(Post) == "post_comments"
  end

  test "comments_table_name/1 with 1 Nesting" do
    assert Commentable.Utils.comments_table_name(Author.Post) == "post_comments"
  end

  test "comments_table_name/1 with 2 Nesting" do
    assert Commentable.Utils.comments_table_name(Human.Author.Post) == "post_comments"
  end
end
