class GraphqlController < ApplicationController
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
      pundit: self
    }
    result = GraphqlStoreSchema.execute(
      query,
      variables:
      variables,
      context: context,
      operation_name: operation_name
    )
    render json: result
  end
end
