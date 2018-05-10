class ApplicationController < ActionController::Base
  def list_posts
    posts = connection.execute("SELECT * FROM posts")

    render 'application/list_posts', locals: { posts: posts }
  end
  
  def show_post
    post = Post.find(params['id'])

    render 'application/show_post', locals: { post: post }
  end
  
  def new_post
    render 'application/new_post'
  end
  
  def create_post
    post = Post.new('title' => params['title'],
                    'body' => params['body'],
                    'author' => params['author'])
    post.save
    redirect_to '/list_posts'
    #binding.pry
  end
  
  def edit_post
    post = Post.find(params['id'])

    render 'application/edit_post', locals: { post: post }
  end
  
  def update_post
    update_query = <<-SQL
      UPDATE posts
      SET title      = ?,
          body       = ?,
          author     = ?
      WHERE posts.id = ?
    SQL
    connection.execute update_query, params['title'], params['body'], params['author'], params['id']

    redirect_to '/list_posts'
  end
  
  def delete_post
    connection.execute("DELETE FROM posts WHERE posts.id = ?", params['id'])

    redirect_to '/list_posts'
  end
  
  private

  def connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end
end