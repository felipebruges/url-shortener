class ShortUrl < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :original, :short, :slug
  validates_uniqueness_of :original, :slug
  validates :original, format: URI::regexp(%w[http https])

  before_validation :save_shortened_url

  BASE_URL = 'http://localhost:3000'

  def self.generate_slug
    SecureRandom.alphanumeric(10)
  end

  def self.generate_url(slug)
    "#{BASE_URL}/#{slug}"
  end

  private

  def save_shortened_url
    self.slug ||= ShortUrl.generate_slug
    self.short = ShortUrl.generate_url(slug)
  end
end
