class PostCommentsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    #下記の省略形
      #comment = PostComment.new(post_comment_params)
      #comment.user_id = current_user.id
    @post_comment.book_id = @book.id
    @post_comment.save
    #redirect_to book_path(book)(非同期通信化)
    render 'post_comments/post_comments'
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id]).destroy
    #redirect_to book_path(params[:book_id])(非同期通信化)
    @book = Book.find(params[:book_id])
    render 'post_comments/post_comments'
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
