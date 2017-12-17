require 'search_object/plugin/graphql'

class Resolvers::BaseSearchResolver
  include SearchObject.module(:graphql)

  OrderDirectionEnum = GraphQL::EnumType.define do
    name 'OrderDirection'

    value 'ASC'
    value 'DESC'
  end

  option :id, type: types.String, with: :apply_id_filter
  option :limit, type: types.Int, with: :apply_limit_filter
  option :offset, type: types.Int, with: :apply_offset_filter
  option :updated_at_after, type: Types::DateTimeType, with: :apply_updated_at_after_filter
  option :created_at_after, type: Types::DateTimeType, with: :apply_created_at_after_filter
  option :deleted_at_after, type: Types::DateTimeType, with: :apply_deleted_at_after_filter
  option :updated_at_before, type: Types::DateTimeType, with: :apply_updated_at_before_filter
  option :created_at_before, type: Types::DateTimeType, with: :apply_created_at_before_filter
  option :deleted_at_before, type: Types::DateTimeType, with: :apply_deleted_at_before_filter
  option :order_direction, type: OrderDirectionEnum, default: 'ASC'

  def apply_id_filter(scope, value)
    scope.where id: value
  end

  def apply_limit_filter(scope, value)
    scope.limit(value)
  end

  def apply_offset_filter(scope, value)
    scope.offset(value)
  end

  def escape_search_term(term)
    "%#{term.gsub(/\s+/, '%')}%"
  end

  def apply_created_at_after_filter(scope, value)
    scope.where 'created_at >= ?', value
  end

  def apply_updated_at_after_filter(scope, value)
    scope.where 'updated_at >= ?', value
  end

  def apply_deleted_at_after_filter(scope, value)
    scope.where 'deleted_at >= ?', value
  end

  def apply_created_at_before_filter(scope, value)
    scope.where 'created_at <= ?', value
  end

  def apply_updated_at_before_filter(scope, value)
    scope.where 'updated_at <= ?', value
  end

  def apply_deleted_at_before_filter(scope, value)
    scope.where 'deleted_at <= ?', value
  end

  def apply_order_direction_with_asc(scope); end

  def apply_order_direction_with_dec(scope); end

  def apply_order_by_with_created_at(scope)
    scope.order "created_at #{order_direction}"
  end

  def apply_order_by_with_updated_at(scope)
    scope.order "updated_at #{order_direction}"
  end
end
