import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  navigate(event) {
    // Don't navigate if clicking on a link or button
    if (event.target.closest('[data-clickable-row-target="link"]')) {
      return
    }

    // Navigate to the URL specified in data-url
    window.location.href = this.element.dataset.url
  }
} 