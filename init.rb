# Include hook code here
require_dependency "i18n_in_place_edit"

config.to_prepare do 
	ApplicationController.helper(InPlaceEditTranslationsHelper) 
end