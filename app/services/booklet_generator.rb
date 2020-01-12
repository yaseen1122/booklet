class BookletGenerator
  require 'cloudmersive-convert-api-client'

  def initialize(selected_booklet_files)
    @selected_booklet_files = selected_booklet_files
  end

  def result
    @selected_booklet_files.each do |k,value|
      @tbc = Tbc.find(k)
      @tbc_attached_files = value.reject(&:empty?)

      @tbc_attached_files.each do |tbc_file|
        debugger
        tbc_file
      end

    end
  end

end


# (CombinePDF.load(aa[0]) << CombinePDF.load(aa[1])).save("out.pdf")
