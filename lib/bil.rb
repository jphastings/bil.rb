require 'bil/version'
require 'bil/packer'
require 'bil/unpacker'
require 'stringio'

module BIL
  TABLE = %w(z a b c d e f g h j k p q r t u Y A B C D E F G H J K P Q R T U).freeze

  # Convenience method for packing an array of integers
  # into a bil encoded string.
  #
  # @param array_of_ints [Array<Integer>] An array of unsigned integers
  # @return [String] The bil encoded string
  def self.pack(*array_of_ints)
    ''.tap do |string|
      Packer.new do |chunk|
        string << chunk
      end.pack(*array_of_ints)
    end
  end

  # Convenience method for unpacking a bil encoded string into an array of
  # integers. Unknown characters will be ignored.
  #
  # NB. This will only unpack the first bil encoded list within a string.
  # For greater flexibility, look at Bil::Unpacker
  #
  # @param string [String] The bil encoded string
  # @return [Array<Integer>] The array of integers represented by the string
  def self.unpack(string)
    [].tap do |array|
      Unpacker.new do |int|
        array << int
      end.unpack(StringIO.new(string))
    end
  end
end
