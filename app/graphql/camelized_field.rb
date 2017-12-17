module CamelizedField
  def self.call(target, field_name, *args, &block)
    # modify the incoming name:
    camelized_field_name = field_name.to_s.camelize(:lower)

    # use the original name as the `property:` keyword argument:
    if args.last.is_a?(Hash)
      keyword_args = args.last
    else
      keyword_args = {}
      args << keyword_args
    end
    keyword_args[:property] = field_name

    # use the new name to create a GraphQL::Field:
    GraphQL::Define::AssignObjectField.call(target, camelized_field_name, *args, &block)
  end
end
