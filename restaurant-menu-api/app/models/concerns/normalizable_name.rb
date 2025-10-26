module NormalizableName
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_name
  end

  private

  def normalize_name
    return if name.blank?

    normalized = name.strip.squeeze(' ')
    normalized = normalized.titleize
    self.name = normalized
  end
end
