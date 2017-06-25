class UsersController < ApplicationController
  before_action :authenticate, except: [:create, :auth]
  before_action :set_user, only: [:show, :email, :update, :destroy]

  # GET /users
  def index
    @users = User.short

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: {id: @user.id, token: @user.token, roles: @user.roles.map(&:name)}, status: :created, location: @user
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # POST /users/1/email
  def email
    ApplicationMailer.user_email(@user, params[:email]).deliver_later
  end

  def auth
    @user = User.find_by_email(params[:email]).try(:authenticate, params[:password])

    if @user
      render json: {id: @user.id, token: @user.token, roles: @user.roles.map(&:name)}
    else
      render json: {errors: {email: ['User name or password are invalid']}}, status: :unauthorized
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
  def set_user
    @user = User.find_by_id(params[:id])

    render status: :not_found unless @user.present?
  end

  def authenticate
    @authorized_user = authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token|
      User.find_by_token token
    end
  end

  def render_unauthorized
    render status: :unauthorized
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :bio, :birth_date)
  end
end
