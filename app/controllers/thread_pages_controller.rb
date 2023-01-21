class ThreadPagesController < ApplicationController
  before_action :set_thread_page, only: %i[ show update destroy ]

  # Abstraction for search title algorithm
  def search_title_alg
    @thread_pages_search_title = ThreadPage.where("title ILIKE ?", "%" + ThreadPage.sanitize_sql_like(search_title_params[:title]) + "%")
      .order(created_at: :desc)
  end

  # POST /thread_pages/search/title
  # When frontend search button clicked, render matching thread pages (in "title" search mode)
  def search_title
    @thread_pages_search_title = search_title_alg

    render json: @thread_pages_search_title, include: [:comments, user: {only: :username}]
  end

  # POST /thread_pages/search/title/autocomplete
  # Only render titles json to list in frontend searchbar autocomplete (in "title" search mode)
  def search_title_autocomplete
    @thread_pages_search_title = search_title_alg.take(10)

    render json: @thread_pages_search_title
  end

  # Abstraction for search tags algorithm
  def search_tags_alg
    @tags_array = search_tags_params[:tagsArray]

    @thread_pages_search_tags = ThreadPage.all
    @tags_array.each do |tag|
      @thread_pages_search_tags = @thread_pages_search_tags.where("tags ILIKE ?", "%" + @thread_pages_search_tags.sanitize_sql_like(tag) + "%")
    end

    @thread_pages_search_tags.order(created_at: :desc)
  end

  # POST /thread_pages/search/tags
  # When frontend search button clicked, render matching thread pages (in "tags" search mode)
  def search_tags
    @thread_pages_search_tags = search_tags_alg

    render json: @thread_pages_search_tags, include: [:comments, user: {only: :username}]
  end

  # POST /thread_pages/search/tags/autocomplete (in "tags" search mode)
  def search_tags_autocomplete
    @thread_pages_search_tags = search_tags_alg.take(10)

    render json: @thread_pages_search_tags
  end

  # GET /thread_pages/mythreads
  # Display threads belonging to user
  # Frontend: display "loading...", until threads json loaded
  # Else if errer: display error
  def mythreads
    @mythreads = ThreadPage.where("user_id = ?", params[:user_id]).order(created_at: :desc)
    render json: @mythreads, include: [:comments, user: {only: :username}]
  end

  # GET /thread_pages
  # Display a list of all threads (starting from latest thread)
  # Frontend: display "loading...", until threads json loaded
  # Else if error: display error
  def index
    @thread_pages = ThreadPage.all

    render json: @thread_pages.order(created_at: :desc), 
      include: [:comments, user: {only: :username}]
  end

  # GET /thread_pages/id
  # Display a thread and associated comments (as a thread page)
  # Frontend: display "loading...", until threads and comments json loaded
  # Else if error: display error
  def show
    render json: @thread_page, include: [comments: {include: [user: {only: :username}]}, user: {only: :username}]
  end

  # POST /thread_pages
  # Create a new thread
  # Frontend: if created, display success message and reload window
  # Else if error: display errors through array of error string
  def create
    @thread_page = ThreadPage.new(thread_page_params)

    if @thread_page.save
      render json: @thread_page, status: :created, location: @thread_page
    else
      render json: @thread_page.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /thread_pages/id
  # Edit a thread
  # Frontend: if edited, display success message and reload window
  # Else if error: display errors through array of error string
  def update
    if @thread_page.update(thread_page_params)
      render json: @thread_page
    else
      render json: @thread_page.errors, status: :unprocessable_entity
    end
  end

  # DELETE /thread_pages/id
  # Delete thread
  # Frontend: if deleted, display success message,
  #   and if in individual thread page, redirect to home,
  #   else if in home already, reload window
  # Else if error: display errors through array of error string
  def destroy
    @thread_page.destroy
  end

  private
    # Abstraction for parameters
    def set_thread_page
      @thread_page = ThreadPage.find(params[:id])
    end

    def thread_page_params
      params.permit(:title, :body, :user_id, :tags)
    end

    def search_title_params
      params.permit(:title)
    end

    def search_tags_params
      params.permit(tagsArray: [])
    end
end
