class PostCommentsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    #下記の省略形
      #comment = PostComment.new(post_comment_params)
      #comment.user_id = current_user.id
    comment.book_id = @book.id
    comment.save
    #redirect_to request.referer(非同期通信化)
    render 'post_comments/post_comments'
  end
  
  def destroy
    #自分の回答 PostComment.find(params[:id]).destroy
    @post_comment = PostComment.find_by(id: params[:id], book_id: params[:book_id].destroy
    #redirect_to request.referer(非同期通信化)
    @book = Book.find(params[:book_id])
    render 'post_comments/post_comments'
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
