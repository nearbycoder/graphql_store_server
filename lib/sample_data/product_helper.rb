module SampleData
  module ProductHelper
    def self.product_identifier
      Product.count + 1
    end

    def self.create_products(count = 100)
      products = []
      count.times.each do |_x|
        products << create_product
      end

      products
    end

    def self.create_product
      name = Faker::Food.dish
      description = "#{Faker::Food.ingredient}, #{Faker::Food.ingredient}, #{Faker::Food.ingredient}"

      product = Product.create!(
        name: name,
        description: description,
        image: URI.parse('https://source.unsplash.com/random')
      )

      5.times.each do |_x|
        name = Faker::Food.dish
        description = "#{Faker::Food.ingredient}, #{Faker::Food.ingredient}, #{Faker::Food.ingredient}"
        price = [*1000..30_000].sample
        Variant.create(product: product, name: name, description: description, price: price)
      end

      product
    end
  end
end
