import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Add fade-in animation
    this.element.classList.add("animate-fade-in")
    
    // Auto-dismiss after 3 seconds
    setTimeout(() => {
      this.element.classList.add("animate-fade-out")
      setTimeout(() => {
        this.element.remove()
      }, 300)
    }, 3000)
  }
} 