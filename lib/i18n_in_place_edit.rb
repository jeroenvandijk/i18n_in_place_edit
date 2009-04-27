if ENV['TRANSLATION_MODE'] == "1"
	module I18n
		class << self
			def translate_with_in_place_edit(*args)
				# Add translation counter for unique ids
				@translation_counter ||= 0
				@translation_counter += 1
			
				key = args.first
				classes = ["translateable"]
				begin
					translation = translate_without_in_place_edit(*args)
				rescue
					translation = key.split(".").join(", ")
					classes << "translation_missing"
				end
				%(<span id="translation_[#{key}]_value_#{@translation_counter}" class="#{classes.join(" ")}" rel="/in_place_edit_translations/#{key}" >#{translation}</span>)
			end

			alias_method_chain :translate, :in_place_edit

		end
	end
end