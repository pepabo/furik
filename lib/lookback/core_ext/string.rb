class String
  def underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr('-', '_').
      downcase
  end

  def plain
    self.gsub("\r\n", ' ').gsub(/[\s\-_=]{2,}/, ' ').strip
  end

  def cut(size = 50, options = {})
    text = self.dup
    options[:omission] ||= '...'
    chars = ''
    current_size = 0
    text.each_char do |c|
      current_size += c =~ /^[ -~｡-ﾟ]*$/ ? 1 : 2
      break if current_size > size
      chars << c
    end
    chars << options[:omission] if current_size > size
    chars.to_s
  end
end
