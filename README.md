# TaxReceipts

## Description

Generate tax receipts for our donors based on QuickBooks reports in CSV format, and print them out as PDF files.


## Installation

```elixir
@deps [
  tax_receipts: "~> 0.1.0"
]
```

## License

> TODO: Add license

## Notes

We use two reports from QuickBooks:
 - Sales by Customer Summary (:name, :amount)
 - Customer Contact List (_blank, :name, :full_address)

https://github.com/gutschilla/elixir-pdf-generator

brew install Caskroom/cask/wkhtmltopdf
downloaded goon from https://github.com/alco/goon/releases/ and placed it into ~/bin
mix deps.get

Using EEx templates:
https://codewords.recurse.com/issues/five/building-a-web-framework-from-scratch-in-elixir

html = "<html><body><p>Hi there!</p></body></html>"
pdf_options = Application.fetch_env!(:pdf_generator, :pdf_options)
{ :ok, filename }    = PdfGenerator.generate html, shell_params: pdf_options

# Inline images in html
https://elixirforum.com/t/pdf-generation-with-pdfgenerator/9963


----
Created:  2018-03-10Z
