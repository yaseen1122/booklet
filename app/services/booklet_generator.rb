require 'RMagick'

class BookletGenerator
  include Magick
  CONVERTABLE_FILES_EXT = ['png','bmp','tif','tiff','jpeg','jpg']

  def initialize(selected_booklet_files, bookleet_name)
    @selected_booklet_files = selected_booklet_files
    @bookleet_name = bookleet_name
    @pdf = CombinePDF.new
  end

  def result
    toc_record     = Hash.new
    begin
      collective_categories = @selected_booklet_files.keys
      collective_files      = @selected_booklet_files.values.flatten.compact.reject(&:empty?)
      first_pdf_path = collective_files.delete_at(0)
      if  CONVERTABLE_FILES_EXT.include?(get_file_ext_from_path(first_pdf_path)) 
        first_pdf_path = convert_tiff_to_pdf(first_pdf_path)
      end
      toc_record[first_pdf_path] = 1
      destination    = "#{Rails.root}/booklet_files/#{@bookleet_name}.pdf"

      Prawn::Document.generate(destination,{:page_size =>  [595.28, 841.89],:skip_page_creation => true,:template => first_pdf_path}) do |pdf|

        collective_files.each_with_index do |pdf_path,index|

          if  CONVERTABLE_FILES_EXT.include?(get_file_ext_from_path(pdf_path)) 
            pdf_path = convert_tiff_to_pdf(pdf_path)
          end

          if index == 0
            toc_record[@selected_booklet_files.values.flatten.compact.reject(&:empty?).first] = 1
          end

          pdf.go_to_page(pdf.page_count)
          toc_record[pdf_path] = (pdf.page_number.to_i + 1)
          template_page_count = Prawn::Document.new(:template => pdf_path).page_count

          (1..template_page_count).each_with_index do |template_page_number, index|
            pdf.start_new_page(:template => pdf_path, :template_page => template_page_number)
          end
        end
        add_page_numbers(pdf)
        table_of_content @selected_booklet_files, toc_record , pdf
        delete_all_convertable_files
      end
      return "200"
    rescue Exception => e
      return "500"
    end
  end

  def get_file_ext_from_path(file_path)
    file_path.split(".").last
  end

  def convert_tiff_to_pdf(file_path)
    conv_image      = Image.read(file_path).first
    conv_file_name  = file_path.split("/").last.split(".").first
    saved_file_dest = "#{Rails.root}/booklet_converted_files/#{conv_file_name }.pdf"
    pdf_converted   = conv_image.write(saved_file_dest) {self.page = "798x1125"}
    if File.exists?(saved_file_dest)
      saved_file_dest
    else
      "500"
    end
  end



  def table_of_content files_with_cat, toc_record, pdf

    pdf.go_to_page(0)
    pdf.start_new_page
    index_val = 0 
    pdf.text "<u>TABLE OF CONTENTS</u>", size: 24,:style => :bold, :align => :center, :inline_format => true, :color => "000000"

    files_with_cat.each do |k, value|
      @tbc = Tbc.find(k)
      index_val+= 1
      pdf.text "#{ (index_val).to_s+ "."+ @tbc.name}", size: 16, style: :bold, :color => "000000"
      pdf.text "\n"
      pdf_file_paths = value.reject(&:empty?)
      pdf_file_paths.each do |pdf_file|
        if CONVERTABLE_FILES_EXT.include?(get_file_ext_from_path(pdf_file)) 
          firt_part  = pdf_file.split("/")[0..-3].join('/')
          second_part = "/booklet_converted_files/" + pdf_file.split("/").last.split(".").first.split('.').first + ".pdf"
          pdf_file = firt_part + second_part
        end
        pdf_file_number = toc_record.select{|k,value| k == pdf_file}.present? ? toc_record.select{|k,value| k == pdf_file}.values.try(:last) : ""
        pdf.indent 30, 0 do
          dots = 100 - pdf_file.split("/").last.split(".").first.length 
          pdf.text "#{pdf_file.split("/").last.split(".").first.to_s + ("." * dots) + pdf_file_number.to_s}", size: 12, :color => "000000"
          pdf.text "\n"
        end
      end
    end
  end 

  def delete_all_convertable_files
    all_directory_files = "#{Rails.root}/booklet_converted_files"
    FileUtils.rm_rf Dir.glob("#{all_directory_files}/*") if all_directory_files.present?
  end

  def add_page_numbers(pdf)
    page_number_string = 'Booklet Page No.: <page> of <total>'
    options = {
      at:  [pdf.bounds.right - 175, pdf.bounds.bottom + 25],
      width: 150, 
      align: :right, 
      size: 10,
      page_filter: lambda { |pg| pg }, 
      start_count_at: 1,
      color: 'FF0000'
    }
    pdf.number_pages(page_number_string, options)
  end

end
