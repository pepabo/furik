require 'erb'

module Furik
  class Formatter
    def initialize(template_path:)
      @template = File.read(template_path)
    end

    def format(properties)
      ERB.new(@template).result(binding)
    end
  end
end