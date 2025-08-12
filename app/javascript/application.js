// app/javascript/application.js
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import "controllers"

// // (اختياري: لرفع الملفات المباشر مع Active Storage)
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

window.Stimulus = Application.start()
Stimulus.load(controllers)

