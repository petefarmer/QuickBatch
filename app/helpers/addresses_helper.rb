module AddressesHelper
  def country_options_for_select
    ISO3166::Country.all.map do |country|
      [country.name, country.alpha2]
    end.sort_by(&:first)
  end

  def country_name(code)
    ISO3166::Country.find_country_by_alpha2(code)&.name || code
  end
end 