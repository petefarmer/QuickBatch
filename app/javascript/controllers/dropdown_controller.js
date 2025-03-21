import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "button", "value"]
  static values = {
    itemId: String,
    field: String
  }

  connect() {
    this.closeMenu()
  }

  toggleMenu(event) {
    event.preventDefault()
    if (this.menuTarget.classList.contains("hidden")) {
      this.openMenu()
    } else {
      this.closeMenu()
    }
  }

  openMenu() {
    this.menuTarget.classList.remove("hidden")
    document.addEventListener("click", this.closeMenuOnClickOutside.bind(this))
  }

  closeMenu() {
    this.menuTarget.classList.add("hidden")
    document.removeEventListener("click", this.closeMenuOnClickOutside.bind(this))
  }

  closeMenuOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.closeMenu()
    }
  }

  selectOption(event) {
    event.preventDefault()
    const option = event.currentTarget
    const value = option.dataset.value
    const label = option.textContent.trim()
    
    this.valueTarget.textContent = label
    this.valueTarget.classList.remove("text-gray-500")
    this.valueTarget.classList.add("text-gray-900")
    
    // Here you would typically make an AJAX call to update the value
    // For now, we'll just close the menu
    this.closeMenu()
  }
} 