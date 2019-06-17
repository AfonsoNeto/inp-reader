class Parser::Line
  module SEPARATORS
    COMMENT         = '$'
    END_OF_OBJECT   = '..'
    ATTR_DEFINITION = '='
  end

  attr_accessor :name, :inp_object_type
  attr_accessor :attr, :value

  def initialize(body)
    return nil unless body

    @body = body.strip
    @attr, @value = body_splitted_and_filtered
    @name, @inp_object_type = [@attr, @value]

    typecast_fields!
  end

  def comment?
    @body.start_with? SEPARATORS::COMMENT
  end

  def end_of_object_description?
    @body.include? SEPARATORS::END_OF_OBJECT
  end

  def empty?
    @body.empty? || [@attr, @value].any?(&:blank?)
  end

  private

    def body_splitted_and_filtered
      @body.split(SEPARATORS::ATTR_DEFINITION).map do |string|
        string.to_s.strip.gsub("\"", '').strip
      end
    end

    def typecast_fields!
      typecast_attr! && typecast_value!
      nil
    end

    def typecast_attr!
      @attr = @attr.to_s.parameterize.underscore.to_sym
    end

    def typecast_value!
      return unless @value

      begin
        # Try converting to Integer
        @value = Integer(@value)

      rescue ArgumentError
        begin
          # If Integer conversion fails, try converting to Float
          @value = Float(@value)

        rescue ArgumentError
          # If none was possible, keep it as it is
          @value
        end
      end
    end
end
