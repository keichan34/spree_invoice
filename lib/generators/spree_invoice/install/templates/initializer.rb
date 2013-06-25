require 'wicked_pdf'

if defined?(WickedPdf)
  WickedPdf.config = {
    :exe_path => '/usr/local/bin/wkhtmltopdf'
  }
end

WickedPdf.config = {
  :exe_path => SpreeInvoice::WKHTMLToPDF.bin_path
}

SpreeInvoice.setup do |config|

  config.on_confirm_email = true
  config.invoice_number_generation_method = lambda { |next_invoice_count|
        number = "%04d" % next_invoice_count.to_s
        "R-#{Time.now.year}-#{number}"
  }
  
  config.invoice_template_path = "app/views/spree/invoices/invoice_template.html.erb"
  config.except_payment = ['Spree::PaymentMethod::Check']
  config.wkhtmltopdf_margin = {
    :top    => 20,
    :bottom => 20,
    :left   => 25,
    :right  => 25
  }

  config.invoice_seller_details = %Q|
  Spree Demo
  P.IVA: 12345678901
  C.F.: 12345678901
  Street Address, 12
  00000 City (STATE)
  |


  config.invoice_seller_logo = Spree::Config[:admin_interface_logo]

end

