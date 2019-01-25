# TaxReceipts

## Description

Generate tax receipts for our donors based on QuickBooks reports in CSV format, and print them out as PDF files.


## Installation

```elixir
@deps [
  tax_receipts: "~> 0.2.0"
]
```

## How to use

Place your template in `templates` directory.
Adjust configuration in `config.exs`.

```elixir
csv = "../tmp/Sales by Customer Summary with address and email.CSV"  # path relative to lib.
headers = [:name, :amount, :address, :email]  # should be no headers row in csv.
TaxReceipts.parse(csv, headers)

TaxReceipts.print()
```

Generated pdf files should appear in `output` directory.

## Notes

We use two reports from QuickBooks:
 - Sales by Customer Summary (:name, :amount)
 - Customer Contact List (:name, :address)

PDF generator library:
https://github.com/gutschilla/elixir-pdf-generator

Install dependancies:
brew install Caskroom/cask/wkhtmltopdf
downloaded goon from https://github.com/alco/goon/releases/ and placed it into ~/bin
mix deps.get

An example of using EEx templates:
https://codewords.recurse.com/issues/five/building-a-web-framework-from-scratch-in-elixir

```elixir
html = "<html><body><p>Hi there!</p></body></html>"
pdf_options = Application.fetch_env!(:pdf_generator, :pdf_options)
{ :ok, filename }    = PdfGenerator.generate html, shell_params: pdf_options
```

Using inline images in html:
https://elixirforum.com/t/pdf-generation-with-pdfgenerator/9963


----
Created:  2018-03-10Z
