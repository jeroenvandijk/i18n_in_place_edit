class InPlaceEditTranslationsController < ApplicationController
	def update
		key = params[:id].gsub('.json', '')
		translation = params[:translation][key]
		
		key = find_alternative_key(key)
		
		save_translation(key, translation)
	
		render :json => translation.to_json, :status => :ok
	end
	
	def find_alternative_key(key)
		object, attribute = key.split('.')
		
		begin
			class_instance = object.classify.constantize
			
			# If the class responds to the attribute there is a (virtual) attribute
			if class_instance.new.respond_to?(attribute)
				key = "activerecord.attributes." + key
			end
		rescue NameError
			# Do nothing
		end
		
		key
	end
	
	def save_translation(orig_key, translation)
		key = orig_key.dup
		
		locale = I18n.default_locale.to_s
	
		# Create or open the yml file. This file should be loaded last therefore it is prefixed with 'zzz'
		path = File.join(RAILS_ROOT, "config/locales", "zzz-#{locale}-in_place_edit.yml")

		# update current translations
		translations =  File.exists?(path) ? YAML::load_file(path) : {}
		translations[locale] ||= {}
		current_translation = translations[locale]
	
		last = key.slice!(/.\w+\z/).gsub('.', '')
		current_translation = key.split('.').inject(current_translation) do |current, key| 
			current[key] ||= {}
			current = current[key]
		end

		current_translation[last] = translation

		# Save new translations
		File.open(path, 'wb') { |file| file.write( translations.to_yaml ) }
	
		# Reload translations
		I18n.reload!
	end
	
end