class ModelServices::BaseModelService
  attr_reader :args, :ctx

  def initialize(args, ctx)
    @args = args
    @ctx = ctx
  end

  def authorize(record, method)
    ctx[:pundit].authorize record, method
  end
end
