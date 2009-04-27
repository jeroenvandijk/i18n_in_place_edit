logger.info "Copying assets to public folder"
File.copy File.join(File.dirname(__FILE__), "assets", "translateable.js"), File.join(RAILS_ROOT, "public", "javascripts", "translateable.js")
File.copy File.join(File.dirname(__FILE__), "assets", "translateable.css"), File.join(RAILS_ROOT, "public", "stylesheets", "translateable.css")