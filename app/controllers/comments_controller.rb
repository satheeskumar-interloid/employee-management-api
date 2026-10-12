
class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /projects/:project_id/comments
  def index
    @comments = @commentable.comments.includes(:user)

    render json: @comments, status: :ok
  end

  # GET /projects/:project_id/comments/:id
  def show
    render json: @comment, status: :ok
  end

  # POST /projects/:project_id/comments
  def create
    @comment = @commentable.comments.build(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: {
        errors: @comment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def edit
  end

  # PATCH/PUT /projects/:project_id/comments/:id
  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: {
        errors: @comment.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:project_id/comments/:id
  def destroy
    @comment.destroy

    head :no_content
  end

  private

  def set_commentable
    if params[:project_id].present?
      @commentable = Project.find(params[:project_id])
    else
      render json: {
        error: "Project ID or Task ID is required."
      }, status: :bad_request
    end
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
