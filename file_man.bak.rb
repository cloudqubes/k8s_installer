module FileMan
	# append a line of string to a file if the line is already not there.
	# add end_of_line character if it is not there
	# @param [String] file absolute or relative path to the file to which the lin will be appended.
	# @parma [String] line_to_append string to be appended to file.
	def self.append_to_file(file, line_to_append)
		File.readlines(file_name).each do |line|
			if line.chomp
		end
		f = File.open(file, 'a')
		f.write()
	end
end