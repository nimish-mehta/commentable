defmodule Simple.Repo.Migrations.CreateTables do
  use Ecto.Migration
  require Commentable
  def change do
    create table(:articles) do
      add :body, :string
    end

    create table(:images) do
      add :url, :string
    end

    article_table_name = String.to_atom(Commentable.comments_table_name(Article))
    create table(article_table_name) do
      Commentable.comment_columns(Article)
    end

    image_table_name = String.to_atom(Commentable.comments_table_name(Image))
    create table(image_table_name) do
      Commentable.comment_columns(Image)
    end
  end
end
