
class BookletGenerator

  def initialize(selected_booklet_files)
    @selected_booklet_files = selected_booklet_files
    @pdf = CombinePDF.new
  end

  def result

    @selected_booklet_files.each do |k,value|
      @tbc = Tbc.find(k)
      pdf_file_paths = value.reject(&:empty?)


      # Prawn::Document.generate("#{Rails.root}/booklet_files/#{@tbc.bookleet.name}_#{Time.now.to_i}.pdf", {:page_size => 'A4',:skip_page_creation => true}) do |pdf|
      #   pdf_file_paths.each do |pdf_file|
      #     if File.exists?(pdf_file)
      #       pdf_temp_nb_pages = Prawn::Document.new(:template => pdf_file).page_count
      #       (1..pdf_temp_nb_pages).each do |tp|
      #         debugger
      #         pdf.start_new_page(:template => pdf_file, :template_page => tp)
      #       end
      #     end
      #   end
      # end

      first_pdf_path = pdf_file_paths.delete_at(0)
      destination    = "#{Rails.root}/booklet_files/#{@tbc.bookleet.name.downcase}-#{Time.now.strftime("%m-%d-%Y-%H:%M:%S").to_s}.pdf"
      begin  
        Prawn::Document.generate(destination,{:page_size =>  [595.28, 841.89],:skip_page_creation => true,:template => first_pdf_path}) do |pdf|
          pdf_file_paths.each do |pdf_path|
            pdf.go_to_page(pdf.page_count)
            template_page_count = Prawn::Document.new(:template => pdf_path).page_count
            (1..template_page_count).each do |template_page_number|
              pdf.start_new_page(:template => pdf_path, :template_page => template_page_number)
            end
          end
          add_page_numbers(pdf)
        end
        return "200"
      rescue Exception => e
        return "500"
      end
    end

    # def count_pdf_pages(pdf_file_path)
    #   pdf = Prawn::Document.new(:template => pdf_file_path)
    #   pdf.page_count
    # end

    # abc = {}
    # @selected_booklet_files.each do |k,value|
    #   @tbc = Tbc.find(k)
    #   @tbc_attached_files = value.reject(&:empty?).insert(0,'')

    #   @tbc_attached_files.each_with_index  do |tbc_file,index|
    #     if index > 0
    #       file = CombinePDF.load(tbc_file, allow_optional_content: true)
    #       @pdf << file if file
    #     end
    #   end
    # end


    # @pdf.number_pages location: [:bottom_right], number_format: 'Booklet Page No: %s of %d', start_at: 2

    # # pdf_first_page = @pdf.pages[0]
    # # # mediabox = pdf_first_page [:CropBox] || pdf_first_page [:MediaBox] #copy page size
    # # title_page = CombinePDF.create_page#make title page same size as first page
    # # title_page.textbox "Table of Contents" ,location: [:top], font_color: [0.0,0,0], font_size: 15, opacity: 1
    # # @pdf >> title_page # the >> operator adds pages at the begining

    # @toc = Hash.new
    # @current_section_header_number = 0 # used to fake up section header's
    # pdf = Prawn::Document.new

    # add_title_page(pdf)

    # 21.times { add_a_content_page(pdf) }

    # fill_in_toc(pdf)

    # add_page_numbers(pdf)


    # debugger

    # pdf.render_file "#{Rails.root}/booklet_files/test.pdf"

  
    # @pdf << pdf if pdf
    # # @pdf.pages[0].textbox "Table of Contents", height: 20, width: 70, y: 596, x: 72
    # output_filepath = "#{Rails.root}/booklet_files/#{@tbc.bookleet.name}_#{Time.now.to_i}.pdf"
    # @pdf.save output_filepath

  end


  # def add_title_page(pdf)
  #   pdf.move_down 200
  #   pdf.text "This is my title page", size: 38, style: :bold, align: :center
  # end

  # def fill_in_toc(pdf)
  #   pdf.go_to_page(1)
  #   pdf.text "This is my title page", size: 38, style: :bold, align: :center

  #   number_of_toc_entries_per_page = 10
  #   offset = (@toc.count.to_f / number_of_toc_entries_per_page).ceil
  #   @toc.each_with_index do |(key, value), index| 
  #     pdf.start_new_page if index % number_of_toc_entries_per_page == 0
  #     pdf.text "#{value}.... page #{key + offset}", size: 38
  #   end
  # end

  # def add_a_content_page(pdf)
  #   pdf.start_new_page
  #   toc_heading = grab_some_section_header_text

  #   @toc[pdf.page_count] = toc_heading

  #   pdf.text toc_heading, size: 38, style: :bold
  #   pdf.text "Here is the content for this section"
  #   # randomly span a section over 2 pages
  #   if [true, false].sample
  #     pdf.start_new_page
  #     pdf.text "The content for this section spans 2 pages"
  #   end
  # end

  def add_page_numbers(pdf)
    page_number_string = 'Booklet Page No.: <page> of <total>'
    options = {
      at: [pdf.bounds.right - 175, 9], 
      width: 150, 
      align: :center, 
      size: 10,
      page_filter: lambda { |pg| pg }, 
      start_count_at: 1,
    }
    pdf.number_pages(page_number_string, options)
  end

  # def grab_some_section_header_text
  #   "Section #{@current_section_header_number += 1}"
  # end

end
# (CombinePDF.load(aa[0]) << CombinePDF.load(aa[1])).save("out.pdf")

     # @pdf.number_pages location: [:bottom_right], number_format: 'Booklet Page No:%s', font_size: 8, opacity: 0.5

# class BookletGenerator
#   require 'cloudmersive-convert-api-client'

#   def initialize(selected_booklet_files)
#     @selected_booklet_files = selected_booklet_files
#     @pdf = CombinePDF.new

#   end

#   def result
#     @selected_booklet_files.each do |k,value|
#       @tbc = Tbc.find(k)
#       @tbc_attached_files = value.reject(&:empty?)

#       @tbc_attached_files.each  do |tbc_file|
#         file = CombinePDF.load(tbc_file, allow_optional_content: true)
#         @pdf << file if file
#       end

#       debugger

#       @pdf.number_pages location: [:bottom_right], number_format: 'Booklet Page No:%s', font_size: 8, opacity: 0.5
#       output_filepath = "#{Rails.root}/booklet_files/#{@tbc.bookleet.name}_#{Time.now.to_i}.pdf"
#       @pdf.save output_filepath

#     end
#   end
# end
# # (CombinePDF.load(aa[0]) << CombinePDF.load(aa[1])).save("out.pdf")
