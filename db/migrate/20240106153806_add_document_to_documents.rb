class AddDocumentToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :documents, :json
  end
end
