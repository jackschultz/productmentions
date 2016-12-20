module ProductsHelper

  def mentions_of_product_in_subsite_within_interval(product, subsite, interval)
    product.mentions.joins(:comment).where("comments.subsite_id = ?", subsite.id).where("comments.written_at > current_date - interval '#{interval}'").group("mentions.id, comments.written_at").order("comments.written_at desc")
  end

  def mentions_of_product_in_product_group_within_interval(product, product_group, interval)
    product.mentions.joins(:comment, :product).where("products.product_group_id = ?", product_group.id).where("comments.written_at > current_date - interval '#{interval}'").group("mentions.id, comments.written_at").order("comments.written_at desc")
  end

end
