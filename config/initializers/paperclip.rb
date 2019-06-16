Paperclip.options[:content_type_mappings] = {inp: "text/plain"}
Paperclip::Attachment.default_options[:path] = "/:class/:attachment/:id/:filename"