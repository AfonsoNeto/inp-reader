class InpParser
  module SEPARATORS
    COMMENT         = '$'
    END_OF_OBJECT   = '..'
    ATTR_DEFINITION = '='
  end

  def initialize file
    return unless file
    @file = file
  end

  def get_all
    for_each_object_described_in(@file) do |inp_object|
      ap inp_object
    end

    nil
  end

  def for_each_object_described_in file, &block
    current_inp_object = OpenStruct.new

    File.readlines(file).each do |line|
      line.strip!

      unless line_is_a_comment?(line)
        line.strip!

        # Can I guarantee `eql?` instead of `include?` here? 🤔
        if line.include?(SEPARATORS::END_OF_OBJECT)
          yield current_inp_object
          current_inp_object = OpenStruct.new
        end

        next if line.strip.empty?
        attr_name, attr_value = line.split(SEPARATORS::ATTR_DEFINITION)

        next if [attr_name, attr_value].any?(&:blank?)
        attr_name.strip!.gsub!("\"", '')
        attr_value.strip!.gsub!("\"", '')

        # The current line is the object name and type
        if current_inp_object.name.blank?
          current_inp_object.name = attr_name
          current_inp_object.type = attr_value

        # It means the curent line is an attribute definition
        else
          attr_name = attr_name.underscore.parameterize
          current_inp_object.send("#{attr_name}=", attr_value)
        end
      end
    end
  end

  private

    def line_is_a_comment? line
      line.strip.start_with?(SEPARATORS::COMMENT)
    end
end