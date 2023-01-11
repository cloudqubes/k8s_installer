require "minitest/autorun"
require_relative "../file_man"

class TestFileMan < Minitest::Test

  def test_append_to_blank_file 
    blank_file = "test/mock_files/blank_file.txt"
    File.write(blank_file, "")
    FileMan.append_to_file(blank_file, "a=b")
    assert_match /a=b\n/, File.read(blank_file)
  end

  def test_do_not_append_if_line_exists 
    config_file = "test/mock_files/config_file.txt"
    config_file_content = "s: 12\na=b\nconfx\n"
    File.write(config_file, config_file_content)    
    FileMan.append_to_file(config_file, "a=b")
    assert_match /s: 12\na=b\nconfx\n\z/, File.read(config_file)
  end
end