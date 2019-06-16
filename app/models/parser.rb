class Parser
  def initialize file
    return nil unless file
    @file = file
  end

  def get_all
    for_each_object_described_in(@file) do |inp_object|
      ap inp_object
    end

    nil
  end

  def for_each_object_described_in file, &block
    current_inp = InpFile.new

    File.readlines(file).each do |file_line|
      line = Line.new(file_line)

      unless line.comment?
        if line.end_of_object_description?
          yield current_inp
          current_inp = InpFile.new
        end

        next if line.empty?

        # The current line is the object name and type
        if current_inp.name.blank?
          current_inp = InpFile.new(line.get_inp_object_header_formatted)

        # It means the curent line is an attribute definition
        else
          current_inp[line.attr] = line.value
        end
      end
    end
  end

  private

    def line_is_a_comment? line
      line.strip.start_with?(SEPARATORS::COMMENT)
    end
end
