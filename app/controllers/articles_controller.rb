class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    # Q. Is the array [@category, @article] the way I specify the params for the create method?
    @category = Category.find_by(params[:category_id])
    @article = @category.articles.new(article_params)
    @article.user_id = session[:id]

    if @article.save
      redirect_to category_article_path(@article.category, @article)
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find_by(id: params[:id])
    @category = @article.category
  end

  def update
    @article = Article.find_by(id: params[:id])
    @article.assign_attributes(article_params)

    if @article.save
      redirect_to category_article_path(@article.category, @article)
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    @category = @article.category
    @article.destroy

    redirect_to category_path(@category.id)
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :price)
  end
end
