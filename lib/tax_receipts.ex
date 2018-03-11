defmodule TaxReceipts do
  require Logger

  alias TaxReceipts.{Donor, Repo}

  @temp_dir Application.get_env(:tax_receipts, :temp_dir)

  # The Sales by Customer Summary report: "../tmp/Sales by Customer Summary 2017.CSV"
  # The Customer Contact List report: "../tmp/Customer Contact List from QuickBooks.CSV"
  def parse(type, filename) do
    headers =
      case type do
        :names -> [:name, :amount]
        :addresses -> [:name, :address]
      end

    filename
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode(headers: headers, strip_fields: true)
    |> Enum.map(fn {status, record} ->
      case status do
        :ok -> Donor.create_or_update(record)
        _ -> {:error, record}
      end
    end)
  end

  def print do
    Donor
    |> Repo.all()
    |> Enum.map(&to_pdf(&1))
  end

  defp to_pdf(donor) do
    copy_image_to_system_tmp_dir()
    html = to_template(donor)
    filename = donor.name
    renamed = Path.join(@temp_dir, "/#{filename}.pdf")
    pdf_options = Application.fetch_env!(:pdf_generator, :pdf_options)

    with {:ok, file} <-
           PdfGenerator.generate(
             html,
             shell_params: pdf_options,
             delete_temporary: true,
             filename: filename
           ) do
      File.rename(file, renamed)
      {:ok, renamed}
    else
      {:error, error} ->
        Logger.error(fn ->
          "Something went wrong: #{inspect(donor)} - #{inspect(error)}"
        end)
    end
  end

  defp to_template(donor) do
    EEx.eval_file("templates/tax_receipt.eex", donor: donor)
  end

  defp copy_image_to_system_tmp_dir do
    File.cp("templates/tax_receipt.png", "#{System.tmp_dir()}/tax_receipt.png")
  end
end
