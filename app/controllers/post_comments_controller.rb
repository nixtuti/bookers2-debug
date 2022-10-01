class PostCommentsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    #下記の省略形
      #@post_comment = PostComment.new(post_comment_params)
      #@post_comment.user_id = current_user.id
    @post_comment.book_id = @book.id
    @post_comment.save
    #redirect_to request.referer(非同期通信化)
    #render 'post_comments/post_comments'
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    #redirect_to request.referer(非同期通信化)
    #render 'post_comments/post_comments'
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
