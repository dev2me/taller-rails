class ArticlesController < ApplicationController
	#before_action -> callback desp
	#after_action -> callback ant
	before_action :authenticate_user!, except: [:show, :index]
	before_action :set_article, except: [:index, :new, :create]
	#GET /articles
	def index
		@articles = Article.all
	end
	#GET /articles/:id
	def show
		@article.update_visits_count
	end
	#GET /articles/new
	def new 
		@article = Article.new
	end
	def edit 
	end
	#POST /articles
	def create
		@article = current_user.articles.new(article_params)
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end
	def destroy
		@article.destroy #Destroy elimina el objeto de la db
		redirect_to articles_path
	end
	#PUT /articles/:id
	def update
		if @article.update(article_params)
			render_to @article
		else
			render :edit
		end
	end
	#Private es una palabra reservada que determina que métodos son de tipo privado por lo que 
	#todo lo que se encuentra debajo de esa palabra se considera como un método o propiedad privada
	private
	def set_article
		@article = Article.find(params[:id])
	end
	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	end 
	def article_params
		#Se hace un require del hash de articulos para despues especificar que campos serán permitidos
		params.require(:article).permit(:title,:body)
	end
end
