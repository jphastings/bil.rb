module BIL
  class Packer
    def initialize(&packed)
      @packed = packed
    end

    def new!
      @packed.call(TABLE[16])
    end

    def pack(*integers, delineate: true)
      new! if delineate

      integers.each do |int|
        memo = Integer(int)
        raise ArgumentError, "Cannot pack negative integers" if memo < 0

        string = ''

        begin
          chunk = memo & 15
          chunk += 16 unless string.empty?
          string.prepend(TABLE[chunk])
          memo = memo >> 4
        end until memo == 0

        @packed.call(string)
      end
    rescue TypeError => e
      raise ArgumentError, e.message
    end
  end
end
