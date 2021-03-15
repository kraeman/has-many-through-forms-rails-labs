class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories, reject_if: proc { |attributes| attributes['name'].blank? }

  def category_attributes=(category_attributes)

    category_attributes.values.each do |category_attribute|
  
      category = Category.find_or_create_by(category_attribute)
      self.categories << category
    end
  end

  def users_who_commented
    list = []
    self.comments.each do |c|
      list << User.find(c.user_id).username
    end
    thing = list.uniq
  end
end
