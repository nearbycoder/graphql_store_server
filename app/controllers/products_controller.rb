class ProductsController < ApplicationController
  def index
    # rubocop:disable LineLength
    query_string = "
      query products($id: ID, $limit: ID, $offset: ID, $name: String, $description: String, $orderDirection: OrderDirection, $orderBy: ProductOrder) {
        products(id: $id, limit: $limit, offset: $offset, name: $name, description: $description, orderDirection: $orderDirection, orderBy: $orderBy) {
          #{product_query}
          #{params[:variants] ? product_variants_query : nil}
        }
    }"
    # rubocop:enable LineLength
    render json: perform_query(query_string, params)
  end

  def show
    query_string = "
      query product($id: ID!) {
        products(id: $id) {
          #{product_query}
          #{params[:variants] ? product_variants_query : nil}
        }
    }"
    render json: perform_query(query_string, params)
  end

  def create
    query_string = "
      mutation createProduct($product: ProductCreateType!) {
        createProduct(product: $product) {
          #{product_query}
        }
    }"
    render json: perform_query(query_string, params)
  end

  def update
    query_string = "
      mutation updateProduct($id: ID!, $product: ProductUpdateType!) {
        updateProduct(id: $id, product: $product) {
          #{product_query}
        }
    }"
    render json: perform_query(query_string, params)
  end

  def deleted
    query_string = "
      mutation product($id: ID!) {
        deletedProduct(id: $id) {
          #{product_query}
        }
    }"
    render json: perform_query(query_string, params)
  end

  private

  def product_query
    "
      id
      name
      description
      createdAt
      updatedAt
      deletedAt
    "
  end

  def product_variants_query
    "
    variants {
      id
      name
      description
      price
      createdAt
      updatedAt
      deletedAt
    }
    "
  end
end
