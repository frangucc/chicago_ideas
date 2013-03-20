module PdfCreator
  def create_pdf(obj, partial_path, file_name, pdf_kit_options={})

    template = File.read("#{Rails.root}/app/views/#{ partial_path }")
    engine = Haml::Engine.new(template)
    html = engine.render(obj)
    # File.open("#{Rails.root}/tmp/pdf/#{file_name}.html", 'w') {|f| f.write(html) }
    pdf_kit_default_options = { "margin-bottom" => "0.5in", "margin-top" => "0.5in", page_size: "Letter" }
    pdf_kit_default_options.merge!(pdf_kit_options)
    kit = PDFKit.new(html, pdf_kit_default_options)
    css_path =  if Rails.env == "development"
                  "#{Rails.root}/app/assets/stylesheets/"
                else
                  "#{Rails.root}/public/assets/"
                end
    kit.stylesheets << css_path + css_name if css_name
    file = kit.to_file("#{Rails.root}/tmp/pdf/#{file_name}")
    file
  end

end