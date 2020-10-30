class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  #comes from activerecord for nested attributes for model
  accepts_nested_attributes_for :categories

#creates a custom setter for the category attributes
  def categories_attributes=(category_attributes)
    #goes through each of the categories values
    category_attributes.values.each do |category_attribute|
      # if the attribute is present 
      if category_attribute["name"].present?
        # it will find or create
        category = Category.find_or_create_by(category_attribute)
        # then pushes the varibale category into post categories
        self.categories << category
      end
    end
  end
end
