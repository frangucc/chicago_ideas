module PdfCreator
  def create_pdf(obj, partial_path, file_name, pdf_kit_options={})
    html  = render_to_string(template: partial_path, layout: false)
    pdf_kit_default_options = { "margin-bottom" => "0.5in", "margin-top" => "0.5in", page_size: "Letter" }
    pdf_kit_default_options.merge!(pdf_kit_options)
    kit = PDFKit.new(html, pdf_kit_default_options)
    file = kit.to_file("#{Rails.root}/tmp/invoice-#{file_name}.pdf")
    file
  end

end