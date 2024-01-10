class Document < ApplicationRecord
  mount_uploaders :documents, DocumentUploader

  belongs_to :user

  validates :title, presence: true
  validates :user, :documents, presence: true
  validate :documents_size


  MEGABYTES_LIMIT = 5

  private

  def documents_size
    return unless documents.size > MEGABYTES_LIMIT.megabytes

    errors.add(:documents, "Lūdzu ielādējiet failu līdz #{MEGABYTES_LIMIT}MB")
  end

end
