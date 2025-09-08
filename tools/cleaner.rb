# frozen_string_literal: true

require 'fileutils'
require 'open3'
require 'readline'
require 'bmi'

# Create runner.
class CleanRunner

  def self.delete
    puts ''
    puts 'Enter yes/no to delete, tab completion is available.'
    puts ''

    sel = %w[yes no].map!(&:freeze).freeze

    Readline.completion_proc = proc {|word|
      sel.grep(/\A#{Regexp.quote word}/)
    }

    filepath = '~/.vim/plugged/deoplete-ruby2/rplugin/python3/deoplete/sources/ruby2.py'.to_s
    git_k = File.basename(File.expand_path(filepath), '.py')
    ruby2_exist = "deoplete-#{git_k}_log"

    encoding_style

    while (line = Readline.readline(""))
      line.chomp!

      if line.match?(sel[0])
        FileUtils.rm_rf(File.expand_path("~/#{ruby2_exist}"))
        puts ''
        puts 'Deleted, the existing deoplete-ruby2_log folder.'
        puts ''
        break
      elsif line.match?(sel[1])
        puts ''
        puts 'You selected No, No action will be taken.'
        puts ''
        break
      else
        puts ''
        puts 'Please enter yes or no as an argument.'
        puts ''
        break
      end
    end
  end

  def self.run
    filepath = '~/.vim/plugged/deoplete-ruby2/rplugin/python3/deoplete/sources/ruby2.py'.to_s
    git_k = File.basename(File.expand_path(filepath), '.py')
    ruby2_exist = "deoplete-#{git_k}_log"

    encoding_style

    if Dir.exist?(File.expand_path("~/#{ruby2_exist}"))
      puts ''
      puts 'Already have a deoplete-ruby2_log folder.'
      delete
    else
      FileUtils.mkdir('deoplete-ruby2_log')
      FileUtils.mv("#{File.dirname(__FILE__)}/deoplete-ruby2_log", File.expand_path('~/'))
      puts ''
      puts 'Created, deoplete-ruby2_log folder.'
      puts ''
    end
  end
end

begin
  CleanRunner.run
rescue StandardError => e
  puts e.backtrace
ensure
  GC.compact
end

__END__
