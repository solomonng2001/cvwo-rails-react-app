class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show update destroy ]

  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/id
  def show
    render json: @comment
  end

  # POST /comments
  # Create new comment
  # Frontend: if success, display success message and reload window
  # Else if error, display error message through array of error strings
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/id
  # Edit comment
  # Frontend: if success, display success message and reload window
  # Else if error, display error message through array of error strings
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/id
  # Frontend: if success, display success message and reload window
  # Else if error, display error message through array of error strings
  def destroy
    @comment.destroy
  end

  private
    # Abstraction for parameters
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.permit(:body, :thread_page_id, :user_id)
    end
end
