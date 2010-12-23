module TextHelper
  def textilize(text)
    super(text).html_safe
  end
  
  def textilize_without_paragraph(text)
    super(text).html_safe
  end
end