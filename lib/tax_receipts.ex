defmodule TaxReceipts do
  require Logger

  alias TaxReceipts.Donor

  @output_dir Application.get_env(:tax_receipts, :output_dir)
  @templates_dir Application.get_env(:tax_receipts, :templates_dir)
  @template Application.get_env(:tax_receipts, :template)
  @logo Application.get_env(:tax_receipts, :logo)
  @tmp_dir Application.get_env(:tax_receipts, :tmp_dir)

  def parse(csv, headers) do
    csv
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
    copy_logo_to_tmp_dir()

    Donor.with_contributions()
    |> Enum.map(&to_pdf(&1))
  end

  defp to_pdf(donor) do
    html = eval_template(donor)
    filename = donor.name
    renamed = Path.join(@output_dir, "/#{filename}.pdf")

    with {:ok, file} <-
           PdfGenerator.generate(
             html,
             delete_temporary: true,
             filename: filename,
             page_size: "letter"
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

  defp eval_template(donor) do
    EEx.eval_file("#{@templates_dir}/#{@template}", donor: donor)
  end

  defp copy_logo_to_tmp_dir do
    File.cp("#{@templates_dir}/#{@logo}", "#{@tmp_dir}/#{@logo}")
  end
end
