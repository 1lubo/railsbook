# frozen_string_literal: true

class AddParentIdToComment < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :parent_id, :integer
  end
end
