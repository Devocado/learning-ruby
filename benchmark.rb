require 'benchmark'

# reads an array of colours representing digits in a barcode
class BarcodeReader
  COLOURS = %w[black brown red orange yellow green blue violet grey white]
            .freeze

  def self.value_string_impl(colours)
    colours.map { |colour| COLOURS.index(colour) }.join.to_i
  end

  def self.value_functional(colours)
    colours.map { |colour| COLOURS.index(colour) }
           .inject(0) { |base, n| base * 10 + n }
  end

  def self.random_barcode(size)
    Array.new(size) { COLOURS[rand(COLOURS.size)] }
  end
end

colour_arr = BarcodeReader.random_barcode(100_000)

Benchmark.bmbm do |x|
  x.report('String') { BarcodeReader.value_string_impl(colour_arr) }
  x.report('functional') { BarcodeReader.value_functional(colour_arr) }
end
