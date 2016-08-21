class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show ]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order('id desc').
      paginate(page: params[:page], per_page: 3)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # 한번 클릭할 때마다 증가
    @post.hit = @post.hit + 1
    @post.save
  end

  def reconum
    @post = Post.find(params[:post_id])
    #@user = User.find(params[:id])
      respond_to do |format|
        if current_user.email == @post.user.email # 자신의 글인지 아닌지 판단
          format.html { redirect_to "/posts", notice: '자신의 글은 추천할 수 없습니다.'}
        else
          @post.reconum = @post.reconum + 1  # 추천수 증가
          @post.save
          format.html { redirect_to "/posts", notice: '추천 성공!' }
        end
      end
  end

  # GET /posts/1/edit
  def edit
    authorize_action_for @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
end
