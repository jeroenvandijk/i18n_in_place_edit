module InPlaceEditTranslationsHelper
	unloadable
	
	def include_in_place_edit_for_translations
		if ENV['TRANSLATION_MODE'] == "1"
			stylesheet_link_tag('translateable') +
			javascript_include_tag('translateable') +
			javascript_tag("document.observe('dom:loaded', function(event) { Translateable.setupAll(); });")
		end
	end
	
end