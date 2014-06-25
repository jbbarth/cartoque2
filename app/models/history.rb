# This object groups query parameters and versions for easier querying in
# HistoryController. Otherwise versions don't contain query parameters, e.g.
# the model or group of models. For now query parameter == model
class History
  attr_accessor :versions, :model

  def initialize(versions, model)
    unless versions.respond_to?(:to_a)
      raise ArgumentError, "wrong order for parameters"
    end
    self.versions = versions
    self.model = model
  end
end
