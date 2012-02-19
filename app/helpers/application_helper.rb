module ApplicationHelper
  def bootstrap_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end
end
