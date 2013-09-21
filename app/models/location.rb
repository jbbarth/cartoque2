class Location < ActiveRecord::Base
  has_ancestry

  # see: https://github.com/stefankroes/ancestry/wiki/Creating-a-selectbox-for-a-form-using-ancestry
  def self.arrange_as_array(options={}, hash=nil)
    hash ||= arrange(options)
    arr = []
    hash.each do |node, children|
      arr << node
      arr += arrange_as_array(options, children) unless children.nil?
    end
    arr
  end

  # see: https://github.com/stefankroes/ancestry/wiki/Creating-a-selectbox-for-a-form-using-ancestry
  def name_for_selects
    "#{'-' * depth} #{name}"
  end

  # see: https://github.com/stefankroes/ancestry/wiki/Creating-a-selectbox-for-a-form-using-ancestry
  def possible_parents
    parents = Location.arrange_as_array(:order => 'name')
    return new_record? ? parents : parents - subtree
  end
end
