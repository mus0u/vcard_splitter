defmodule VcardSplitterTest do
  use ExUnit.Case
	import VcardSplitter

  test "parse returns a List of vcards contained in the given filename" do
		filename = "test/fixtures/vcard-min.vcf"
		expected_result = [ File.read!(filename) ]
		assert parse("test/fixtures/vcard-min.vcf") == expected_result
  end
end
