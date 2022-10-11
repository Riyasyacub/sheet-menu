class Menu < ApplicationRecord
  belongs_to :user
  has_many :menu_items, dependent: :destroy
  has_many :tables, dependent: :destroy
  validates_presence_of :sheet_key, :title

  def self.create_with_sheet_key(menu_params)
    sheet_key     = menu_params['sheet_key']
    items, tables = import_data(sheet_key)
    menu          = self.new(menu_params.merge(title: spreadsheet.title))
    ActiveRecord::Base.transaction do
      menu.save!
      menu_items, menu_tables = assign_data(menu, items, tables)
      MenuItem.import(menu_items) if menu_items.present?
      Table.import(menu_tables) if menu_tables.present?
    end
    menu
  end

  def self.sync!(menu)
    items, tables           = import_data(menu.sheet_key)
    menu_items, menu_tables = assign_data(menu, items, tables)
    MenuItem.import(menu_items, on_duplicate_key_update: { conflict_target: [:menu_id, :item_name], columns: :all }) if menu_items.present?
    Table.import(menu_tables, on_duplicate_key_update: { conflict_target: [:menu_id, :name], columns: :all }) if menu_tables.present?
  end

  private

  def self.import_data(sheet_key)
    credential_file  = Rails.root.join('sheet-menu-362808-25605a1a9055.json').to_s
    session          = GoogleDrive::Session.from_config(credential_file)
    spreadsheet      = session.spreadsheet_by_key(sheet_key)
    items_sheet      = spreadsheet.worksheets[0]
    item_keys, items = items_sheet&.rows&.first, items_sheet&.rows[1..-1]
    item_keys        = item_keys&.map { |k| k.parameterize.underscore.to_sym }
    items            = items&.map { |i| item_keys.zip(i).to_h }
    items            = items&.uniq { |v| v[:item_name] }
    tables_sheet       = spreadsheet.worksheets[1]
    table_keys, tables = tables_sheet&.rows&.first, tables_sheet&.rows[1..-1]
    table_keys         = table_keys&.map { |k| k.parameterize.underscore.to_sym }
    tables             = tables&.map { |i| table_keys.zip(i).to_h }
    tables             = tables&.uniq { |v| v[:name] }

    [items, tables]
  end

  def self.assign_data(menu, items, tables)
    menu_items = items&.map do |item|
      menu.menu_items.new(category:    item[:category],
                          price:       item[:price].to_f,
                          description: item[:description],
                          item_name:   item[:item_name],
                          image_url:   item[:image_url])
    end

    menu_tables = tables&.map do |table|
      menu.tables.new(name:        table[:name],
                      waiter_name: table[:waiter_name],
                      no_of_seats: table[:no_of_seats])
    end

    [menu_items, menu_tables]
  end
end
