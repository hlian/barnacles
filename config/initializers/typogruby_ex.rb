Typogruby.class_eval do
  def improve_ex(text)
    # No more widont -- it looks weird on Chrome 40.
    initial_quotes(caps(smartypants(amp(text))))
  end
end
