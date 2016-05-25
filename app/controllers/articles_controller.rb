class ArticlesController < ApplicationController
	#GET /articles
	def index
		@articles = Article.all
	end
	#GET /articles/:id
	def show 
		@article = Article.find(params[:id])
	end
	#GET /articles/new
	def new 
		@article = Article.new
	end
	def edit 
		@article = Article.find(params[:id])
	end
	#POST /articles
	def create
		@article = Article.new(article_params)
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end
	def destroy
		@article = Article.find(params[:id])
		@article.destroy #Destroy elimina el objeto de la db
		redirect_to articles_path
	end
	#PUT /articles/:id
	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			render_to @article
		else
			render :edit
		end
	end
	#Private es una palabra reservada que determina que métodos son de tipo privado por lo que 
	#todo lo que se encuentra debajo de esa palabra se considera como un método o propiedad privada
	private 
	def article_params
		#Se hace un require del hash de articulos para despues especificar que campos serán permitidos
		params.require(:article).permit(:title,:body)
	end
end
