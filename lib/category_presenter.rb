class CategoryPresenter < Struct.new(:row)
  def to_category
    return Category.create(row) if row[:parent_id].blank?
    return parent_category(row) unless parent_category(row).valid?
    return parent_category(row).children.create(row)
  end

  def parent_category(row)
    Category.find_or_create_by(name: row[:parent_name],
                               taxonomy_id: row[:parent_id])
  end
end
