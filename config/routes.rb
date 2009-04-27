ActionController::Routing::Routes.draw do |map|
	map.resources :in_place_edit_translations, :requirements => { :id => /(.*)/ }
end