# frozen_string_literal: true

#
# base model, this is the super model to handle common methods for all models
#
class BaseModel

  public

  def to_hash
    instance_variables.each_with_object({}) do |var, hash|
      hash[var.to_s.delete('@')] = instance_variable_get(var)
    end
  end
end
