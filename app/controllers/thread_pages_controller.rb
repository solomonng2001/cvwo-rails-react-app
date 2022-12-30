class ThreadPagesController < ApplicationController
  before_action :set_thread_page, only: %i[ show update destroy ]

  # GET /thread_pages
  def index
    @thread_pages = ThreadPage.all

    render json: @thread_pages.order(created_at: :desc), include: [:comments, user: {only: :user}]
  end

  # GET /thread_pages/1
  def show
    render json: @thread_page, include: [:comments, user: {only: :user}]
  end

  # POST /thread_pages
  def create
    @thread_page = ThreadPage.new(thread_page_params)

    if @thread_page.save
      render json: @thread_page, status: :created, location: @thread_page
    else
      render json: @thread_page.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /thread_pages/1
  def update
    if @thread_page.update(thread_page_params)
      render json: @thread_page
    else
      render json: @thread_page.errors, status: :unprocessable_entity
    end
  end

  # DELETE /thread_pages/1
  def destroy
    @thread_page.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thread_page
      @thread_page = ThreadPage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def thread_page_params
      params.require(:thread_page).permit(:title, :body, :user_id)
    end
end
