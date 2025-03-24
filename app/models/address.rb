class Address < ApplicationRecord
  # Constants
  ADDRESS_TYPES = %w[billing shipping office].freeze
  FORMAT_TYPES = %w[us uk eu international].freeze
  
  # Enums
  enum :address_type, ADDRESS_TYPES.zip(ADDRESS_TYPES).to_h
  
  # Associations
  belongs_to :addressable, polymorphic: true
  
  # Validations
  validates :address_type, presence: true, inclusion: { in: ADDRESS_TYPES }
  validates :country_code, presence: true, length: { is: 2 }
  validates :format_type, presence: true, inclusion: { in: FORMAT_TYPES }
  validates :street_address_1, presence: true
  validates :city, presence: true
  validates :state_province, presence: true
  validates :postal_code, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phone, format: { with: /\A\+?[\d\s\(\)\-]+\z/, message: "must be a valid phone number" }, allow_blank: true
  
  # Callbacks
  before_validation :set_format_type_based_on_country
  before_save :ensure_single_default_address
  
  # Scopes
  scope :default, -> { where(is_default: true) }
  scope :by_type, ->(type) { where(address_type: type) }
  scope :by_country, ->(code) { where(country_code: code) }
  
  # Instance methods
  def country_name
    ISO3166::Country.find_country_by_alpha2(country_code)&.name
  end
  
  def formatted_address
    case format_type
    when 'us'
      format_us_address
    when 'uk'
      format_uk_address
    when 'eu'
      format_eu_address
    else
      format_international_address
    end
  end
  
  def self.addressable_types
    %w[Customer]
  end
  
  private
  
  def set_format_type_based_on_country
    return if format_type.present?
    
    case country_code.upcase
    when 'US'
      self.format_type = 'us'
    when 'GB'
      self.format_type = 'uk'
    when *EU_COUNTRIES
      self.format_type = 'eu'
    else
      self.format_type = 'international'
    end
  end
  
  def format_us_address
    [
      attention,
      company_name,
      street_address_1,
      street_address_2,
      [city, state_province, postal_code].compact.join(', '),
      country_code
    ].compact.reject(&:blank?).join("\n")
  end
  
  def format_uk_address
    [
      attention,
      company_name,
      street_address_1,
      street_address_2,
      city,
      postal_code,
      country_code
    ].compact.reject(&:blank?).join("\n")
  end
  
  def format_eu_address
    [
      attention,
      company_name,
      street_address_1,
      street_address_2,
      [postal_code, city].compact.join(' '),
      state_province,
      country_code
    ].compact.reject(&:blank?).join("\n")
  end
  
  def format_international_address
    [
      attention,
      company_name,
      street_address_1,
      street_address_2,
      [city, state_province, postal_code].compact.join(', '),
      country_code
    ].compact.reject(&:blank?).join("\n")
  end
  
  def ensure_single_default_address
    return unless is_default? && is_default_changed?

    Address.where(addressable: addressable, is_default: true)
          .where.not(id: id)
          .update_all(is_default: false)
  end
  
  EU_COUNTRIES = %w[
    AT BE BG HR CY CZ DK EE FI FR DE GR HU IE IT LV LT LU MT NL PL PT RO SK SI ES SE
  ].freeze
end 