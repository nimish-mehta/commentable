alias Simple.Repo

article_data = %Article{body: "123"}
image_data = %Image{url: "123.png"}

Repo.delete_all(Article)
article = Repo.insert!(article_data)

Repo.delete_all(Image)
image = Repo.insert!(image_data)

article_comment = Article.comment_changeset(%Article{}, %{body: "234", comments: [%{comment: "123"}]})
Repo.insert!(article_comment)

article = article |> Repo.preload(:comments)
article_comment = Article.comment_changeset(article, %{comments: [%{comment: "123", commentable_id: article.id}]})
Repo.update!(article_comment)
