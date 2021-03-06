ENV['RDOC_TEST'] = 'yes'

require 'rubygems'
require 'minitest/autorun'
require 'rdoc'
require 'rdoc/stats'
require 'rdoc/options'
require 'rdoc/code_objects'
require 'rdoc/parser/ruby'
require File.expand_path '../xref_data', __FILE__

class XrefTestCase < MiniTest::Unit::TestCase

  def setup
    RDoc::TopLevel.reset
    RDoc::AnyMethod.reset

    @file_name = 'xref_data.rb'
    @xref_data = RDoc::TopLevel.new @file_name

    @options = RDoc::Options.new
    @options.quiet = true

    stats = RDoc::Stats.new 0

    parser = RDoc::Parser::Ruby.new @xref_data, @file_name, XREF_DATA, @options,
                                    stats
    @top_levels = []
    @top_levels.push parser.scan

    generator = Object.new
    def generator.class_dir() nil end
    def generator.file_dir() nil end
    rdoc = RDoc::RDoc.new
    RDoc::RDoc.current = rdoc
    rdoc.generator = generator

    @c1    = @xref_data.find_module_named 'C1'
    @c2    = @xref_data.find_module_named 'C2'
    @c2_c3 = @xref_data.find_module_named 'C2::C3'
    @c3    = @xref_data.find_module_named 'C3'
    @c4    = @xref_data.find_module_named 'C4'
    @c4_c4 = @xref_data.find_module_named 'C4::C4'
    @c5_c1 = @xref_data.find_module_named 'C5::C1'
    @c3_h1 = @xref_data.find_module_named 'C3::H1'
    @c3_h2 = @xref_data.find_module_named 'C3::H2'

    @m1    = @xref_data.find_module_named 'M1'
    @m1_m2 = @xref_data.find_module_named 'M1::M2'
  end

end

