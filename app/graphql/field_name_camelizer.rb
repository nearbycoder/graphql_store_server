class FieldNameCamelizer
  def instrument(_type, field)
    if field.resolve_proc.is_a?(GraphQL::Field::Resolve::NameResolve)
      field.property = field.name.underscore.to_sym
    end

    field.name = field.name.camelize(:lower)

    field.arguments = Hash[
      field.arguments.map do |_name, argument|
        argument.as = argument.name.underscore
        argument.name = argument.name.camelize(:lower)
        [argument.name, argument]
      end
    ]

    field
  end
end
