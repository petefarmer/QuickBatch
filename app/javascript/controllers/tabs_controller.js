import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static values = {
    initialTab: String
  }

  connect() {
    // Get the initial tab from the URL parameter or default to the first tab
    const urlParams = new URLSearchParams(window.location.search)
    const tabParam = urlParams.get('tab')
    const initialTabName = tabParam || this.initialTabValue || "item-master"

    // Find and activate the initial tab
    const initialTab = this.tabTargets.find(tab => tab.dataset.tab === initialTabName) || this.tabTargets[0]
    this.switch({ target: initialTab })
  }

  switch(event) {
    const tab = event.target
    const tabName = tab.dataset.tab

    // Update tab buttons
    this.tabTargets.forEach(t => {
      if (t === tab) {
        t.classList.remove("border-transparent", "text-gray-500", "hover:text-gray-700", "hover:border-gray-300")
        t.classList.add("border-indigo-500", "text-indigo-600")
      } else {
        t.classList.remove("border-indigo-500", "text-indigo-600")
        t.classList.add("border-transparent", "text-gray-500", "hover:text-gray-700", "hover:border-gray-300")
      }
    })

    // Update panels
    this.panelTargets.forEach(panel => {
      if (panel.dataset.tab === tabName) {
        panel.classList.remove("hidden")
      } else {
        panel.classList.add("hidden")
      }
    })

    // Update all edit links with the current tab
    document.querySelectorAll('a[href*="/edit"]').forEach(link => {
      const baseUrl = link.href.split('?')[0]
      link.href = `${baseUrl}?tab=${tabName}`
    })
  }
} 