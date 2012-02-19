class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  delegate :capture, :content_tag, :tag, to: :@template

  def legend(title)
    content_tag(:legend) do
      title
    end
  end

  def field_set(&block)
    content_tag(:fieldset) do
      yield
    end
  end

  %w[text_field email_field text_area].each do |method_name|
    define_method(method_name) do |name, *args, &block|
      content_tag(:div, class: 'control-group') do
        label(name, *args) +
        content_tag(:div, class: 'controls') do
          super(name, *args)
        end
      end
    end
  end

  def password_field(name, *args, &block)
    content_tag(:div, class: 'control-group') do
      label(name, *args) +
      content_tag(:div, class: 'controls') do
        if block_given?
          super(name, *args) + capture(&block)
        else
          super(name, *args)
        end
      end
    end
  end

  def check_box(name, *args)
    content_tag(:div, class: 'control-group') do
      content_tag(:div, class: 'controls') do
        label(name, :class => 'checkbox') do
          super(name, *args) + " " + args[0][:label]
        end
      end
    end
  end

  def inline_help(&block)
    content_tag(:span, class: 'help-inline') do
      yield
    end
  end

  def date_field(name, *args)
    field_id = "#{object.class.to_s.downcase}_#{name}"
    javascript = <<-JAVASCRIPT
    <script type='text/javascript'>
      $(document).ready(function(){ $('##{field_id}').datepicker({dateFormat:'yy-mm-dd'}); })
    </script>
    JAVASCRIPT
    javascript.html_safe + text_field(name, *args)
  end

  def actions(&block)
    content_tag(:div, class: 'form-actions') do
      yield
    end
  end

  def submit(label=nil)
    label ||= "Submit"
    args = { :class => 'btn btn-primary' }
    super(label, args)
  end

  def link_button(label, url, options = {})
    if options[:class]
      options[:class] = 'btn ' + options[:class]
    else
      options[:class] = 'btn'
    end
    @template.link_to label, url, options
  end

  def aligned_content(&block)
    content_tag(:div, class: 'clearfix') do
      content_tag(:div, class: 'input') do
        yield
      end
    end
  end
end