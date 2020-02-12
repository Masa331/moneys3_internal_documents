require 'money_s3'

class Moneys3InternalDocuments
  def initialize(configuration)
    @vat_rule = configuration.fetch :vat_rule
    @accounting_rule = configuration.fetch :accounting_rule
    @internal_documents_series = configuration.fetch :internal_documents_series
  end

  def to_xml(raw)
    internal_documents = raw.map do |item|
      amount = item.fetch :amount

      data = {
        cleneni: @vat_rule,
        pr_kont: @accounting_rule,
        d_rada: @internal_documents_series,
        popis: item[:description],
        celkem: item[:amount],
        dat_uc_pr: item[:date],
        dat_pln: item[:date],
        dat_upl_dph: item[:date],
        souhrn_dph: {
          zaklad0: amount,
          zaklad5: 0,
          zaklad22: 0,
          dph5: 0,
          dph22: 0,
        }
      }

      data.delete_if { |_, v| v.nil? || v == '' }
      data.transform_values! do |value|
        if value.is_a? Hash
          value.transform_values! { |value| value.to_s }
        else
          value.to_s
        end
      end

      data
    end

    money_data = { seznam_int_dokl: internal_documents }
    MoneyS3.build(money_data)
  end
end
