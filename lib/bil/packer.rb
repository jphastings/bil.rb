module BIL
  class Packer
    def initialize(&packer_proc)
      @packer_proc = packer_proc
    end

    # Starts a new array of ints, delineating previous packed ints from the following ones.
    #     packer.pack(1,2,3)
    #     packer.delineate!
    #     packer.pack(4,5,6)
    #     # -> [[1,2,3], [4,5,6]]
    def delineate!
      @packer_proc.call(TABLE[16])
    end

    # Write packed integers to the instatiated packer.
    # Ends previous packs if delineate is true
    def pack(*integers, delineate: true)
      delineate! if delineate

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

        @packer_proc.call(string)
      end
    rescue TypeError => e
      raise ArgumentError, e.message
    end
  end
end
