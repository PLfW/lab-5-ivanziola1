class Api::V1::BooksController < Api::V1::BaseController
  def index
    books = Book.includes(:genres)
                .search(params[:keyword]).filter(params[:filter]).approved
    render json: books, each_serializer: Api::V1::BookSerializer
  end

  def show
    book = Book.find(params[:id])
    render(json: Api::V1::BookSerializer.new(book).to_json)
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: Api::V1::BookSerializer.new(book).to_json, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :amazon_id,
                                 { genre_ids: [] }, :rating)
  end
end
