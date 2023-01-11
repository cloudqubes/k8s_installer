module FileMan
  def self.append_to_file(file, line_to_append) 
    File.readlines(file).each do |line|
      line.chomp!("\n")
      # p line
      if line == line_to_append
        return
      end
    end
    if !line_to_append.end_with?("\n")
      line_to_append = line_to_append + "\n"
    end
    f = File.open(file, 'a')
    f.write(line_to_append)
    f.close
  end
end