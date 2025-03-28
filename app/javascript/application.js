// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Alpine from "alpinejs"

// Initialize Alpine.js
document.addEventListener("turbo:load", () => {
  window.Alpine = Alpine
  Alpine.start()
})
