class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # POST /login => login
  # Frontend:
  #  If successful, reset all inputs to blank, display success message, set current user and token
  #  Else, if unsuccessful, display error messages in array
  def login
    @user = User.find_by_username(user_params[:username])

    if @user && @user.authenticate(user_params[:password])
      payload = {user_id: @user.id}
      token = encode(payload)
      render json: {user: @user, token: token}
    else
      render json: {error: ["Incorrect username or password"]}, status: :unprocessable_entity
    end
  end

  # GET /login => check if user logged in (Frontend: whenever page refreshes)
  # Frontend:
  #  If successful, set current user
  #  Else, if unsuccessful, display error messages in array
  def auto_login
    if logged_in
      render json: current_user
    else
      render json: { error: ["Login required"] }
    end
  end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users => create account
  # Frontend:
  #  If successful, reset all inputs to blank and display success message
  #  Else, if unsuccessful, display error messages in array
  def create
    @user = User.new(new_user_params)

    if @user.save
      render json: @user, status: :created
    else
      # Checks if
      # - password is 10 characters long
      # - password matches password_confirmation
      # - rejects blanks fields
      # - username must be unique
      render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 => change password
  # Frontend:
  #  If successful, reset all inputs to blank and display success message
  #  Else, if unsuccessful, display error messages in array
  def update
    password = change_password_params[:password]
    password_confirmation = change_password_params[:password_confirmation]
    if password.blank?
      render json: {error: ["Password can't be blank"]}, status: :unprocessable_entity
    elsif !password_confirmation.eql?(password)
      render json: {error: ["Password confirmation doesn't match password"]}, status: :unprocessable_entity
    elsif @user.update(change_password_params)
      render json: @user
    else
      # Only checks if password length is at least 10 characters long
      render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Parameter method for login
    def user_params
      params.permit(:username, :password)
    end

    # Parameter method for creating account (includes password confirmation)
    def new_user_params
      params.permit(:username, :password, :password_confirmation)
    end

    # Parameter method for changing password (includes password confirmation)
    def change_password_params
      params.permit(:password, :password_confirmation)
    end

end
