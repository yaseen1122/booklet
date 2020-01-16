require 'prawn'

class TocTest
  def self.create
    @toc = Hash.new
    @current_section_header_number = 0 # used to fake up section header's
    pdf = Prawn::Document.new

    add_title_page(pdf)
    21.times { add_a_content_page(pdf) }

    fill_in_toc(pdf)

    add_page_numbers(pdf)

    pdf.render_file './output/test.pdf'
  end

  def self.add_title_page(pdf)
    pdf.move_down 200
    pdf.text "This is my title page", size: 38, style: :bold, align: :center
  end

  def self.fill_in_toc(pdf)
    pdf.go_to_page(1)

    number_of_toc_entries_per_page = 10
    offset = (@toc.count.to_f / number_of_toc_entries_per_page).ceil
    @toc.each_with_index do |(key, value), index| 
      pdf.start_new_page if index % number_of_toc_entries_per_page == 0
      pdf.text "#{value}.... page #{key + offset}", size: 38
    end
  end

  def self.add_a_content_page(pdf)
    pdf.start_new_page
    toc_heading = grab_some_section_header_text

    @toc[pdf.page_count] = toc_heading

    pdf.text toc_heading, size: 38, style: :bold
    pdf.text "Here is the content for this section"
    # randomly span a section over 2 pages
    if [true, false].sample
      pdf.start_new_page
      pdf.text "The content for this section spans 2 pages"
    end
  end

  def self.add_page_numbers(pdf)
    page_number_string = 'page <page> of <total>'
    options = {
      at: [pdf.bounds.right - 175, 9], 
      width: 150, 
      align: :right, 
      size: 10,
      page_filter: lambda { |pg| pg > 1 }, 
      start_count_at: 2,
    }
    pdf.number_pages(page_number_string, options)
  end

  def self.grab_some_section_header_text
    "Section #{@current_section_header_number += 1}"
  end
end