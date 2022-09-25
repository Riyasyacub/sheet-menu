class Menu < ApplicationRecord
  belongs_to :user
  has_many :menu_items, dependent: :destroy
  validates_presence_of :sheet_key, :title

  def self.create_with_sheet_key(sheet_key)
    credential_file = Rails.root.join('sheet-menu-362808-25605a1a9055.json').to_s
    session         = GoogleDrive::Session.from_config(credential_file)
    spreadsheet     = session.spreadsheet_by_key(sheet_key)
    worksheet       = spreadsheet.worksheets[0]
    keys, items     = worksheet.rows.first, worksheet.rows[1..-1]
    keys            = keys.map { |k| k.parameterize.underscore.to_sym }
    items           = items.map { |i| keys.zip(i).to_h }
    menu            = self.new(title: spreadsheet.title, sheet_key: sheet_key)
    ActiveRecord::Base.transaction do
      menu.save!

      payload = items.map do |item|
        menu.menu_items.new(category:    item[:category],
                            price:       item[:price].to_f,
                            description: item[:description],
                            item_name:   item[:item_name],
                            image_url:   item[:image_url])
      end
      MenuItem.import(payload)
    end
    menu
  end

  def sync!
    self.menu_items.destroy_all
    credential_file = Rails.root.join('sheet-menu-362808-25605a1a9055.json').to_s
    session         = GoogleDrive::Session.from_config(credential_file)
    spreadsheet     = session.spreadsheet_by_key(sheet_key)
    worksheet       = spreadsheet.worksheets[0]
    keys, items     = worksheet.rows.first, worksheet.rows[1..-1]
    keys            = keys.map { |k| k.parameterize.underscore.to_sym }
    items           = items.map { |i| keys.zip(i).to_h }

    payload = items.map do |item|
      self.menu_items.new(category:    item[:category],
                          price:       item[:price].to_f,
                          description: item[:description],
                          item_name:   item[:item_name],
                          image_url:   item[:image_url])
    end
    MenuItem.import(payload)
    self
  end
end
