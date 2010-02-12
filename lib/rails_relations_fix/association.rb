module ActiveRecord
  module Associations
    class AssociationCollection < AssociationProxy
      alias old_destroy destroy
      def destroy(*records)
        old_destroy(*records)
        records.each{ |record| @target.delete(record)}
      end
    end
  end
end