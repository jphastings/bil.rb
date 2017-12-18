module BIL
  class Unpacker
    def initialize(&unpack)
      @unpack = unpack
      @carry = 0
    end

    def unpack(io)
      io.each_char.reduce(true) do |first_iteration, c|
        n = TABLE.index(c)

        next if n.nil?
        break if !first_iteration && n == 16

        increment_carry(n)
        integer_complete if (n & 16) == 0

        false
      end

      finalize
    end

    private

    def increment_carry(n)
      @carry = (@carry << 4) + (n & 15)
    end

    def finalize
      return if @carry == 0
      # Final char assumed to be 'z'
      increment_carry(0)
      integer_complete
    end

    def integer_complete
      @unpack.call(@carry)
      @carry = 0
    end
  end
end
