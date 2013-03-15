module PdfCreator
  def create_pdf(partial_path, css_name, file_name, pdf_kit_options={})
    html = render_to_string(partial: partial_path, layout: false)
    pdf_kit_default_options = { "margin-bottom" => "0.5in", "margin-top" => "0.5in", page_size: "Letter" }
    pdf_kit_default_options.merge!(pdf_kit_options)
    kit = PDFKit.new(html, pdf_kit_default_options)
    css_path =  if Rails.env == "production"
                  "#{Rails.root}/public/assets/"
                else
                  "#{Rails.root}/app/assets/stylesheets/"
                end
    kit.stylesheets << css_path + css_name
    file = kit.to_file("#{Rails.root}/tmp/#{file_name}.pdf")
    file
  end

end