class Parser::Line
  module SEPARATORS
    COMMENT         = '$'
    END_OF_OBJECT   = '..'
    ATTR_DEFINITION = '='
  end

  def initialize(body)
    return nil unless body
    @body = body
  end

  def comment?
    return unless
  end
end
