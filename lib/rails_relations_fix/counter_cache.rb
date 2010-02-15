module ActiveRecord
  module Callbacks
    NEW_CALLBACKS = %w(
      before_add after_add before_remove after_remove
    )

    def self.define_callback_methods
      base = ActiveRecord::Base
      [:create, :update, :destroy].each do |method|
        # Due to using aliast_method_chain for methods like method_name_with_callbacks they are not reading from this file. 
        # They need to be reloaded.
        base.send :alias_method, method, "#{method}_without_callbacks".to_sym
        base.send :alias_method_chain, method, :callbacks
      end
      base.define_callbacks *NEW_CALLBACKS
    end
    
    def create_with_callbacks #:nodoc:
      return false if callback(:before_create) == false
      return false if callback(:before_add) == false if changed?
      result = create_without_callbacks
      callback(:after_add) if changed?
      callback(:after_create)
      result
    end
    
    def update_with_callbacks(*args) #:nodoc:
      return false if callback(:before_update) == false
      return false if callback(:before_add) == false if changed?
      result = update_without_callbacks(*args)
      callback(:after_add) if changed?
      callback(:after_update)
      result
    end
    
    def destroy_with_callbacks #:nodoc:
      return false if callback(:before_destroy) == false
      return false if callback(:before_remove) == false
      result = destroy_without_callbacks
      callback(:after_remove)
      callback(:after_destroy)
      result
    end
    
    def before_add()    end #:nodoc:
    def after_add()     end #:nodoc:
    def before_remove() end #:nodoc:
    def after_remove()  end #:nodoc:
    
  end
  
  module Associations
    module ClassMethods
      def add_counter_cache_callbacks(reflection)
        cache_column = reflection.counter_cache_column

        method_name = "belongs_to_counter_cache_after_add_for_#{reflection.name}".to_sym
        define_method(method_name) do

          association = send(reflection.name, true) rescue nil
          
          if send("#{reflection.primary_key_name}_changed?") && send("#{reflection.primary_key_name}_change") != send("#{reflection.primary_key_name}_change").compact
            association.class.increment_counter(cache_column, association.id) unless association.nil?
          end
        end
        after_add(method_name)

        method_name = "belongs_to_counter_cache_before_remove_for_#{reflection.name}".to_sym
        define_method(method_name) do
          association = send(reflection.name)
          association.class.decrement_counter(cache_column, association.id) unless association.nil?
        end
        before_remove(method_name)

        module_eval(
          "#{reflection.class_name}.send(:attr_readonly,\"#{cache_column}\".intern) if defined?(#{reflection.class_name}) && #{reflection.class_name}.respond_to?(:attr_readonly)"
        )
      end
    end
  end
  
end

