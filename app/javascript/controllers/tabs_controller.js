import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]

  connect() {
    this.showTab("item-master")
  }

  switch(event) {
    const tab = event.currentTarget
    const tabId = tab.dataset.tab
    this.showTab(tabId)
  }

  showTab(tabId) {
    // Update tab styles
    this.tabTargets.forEach(tab => {
      if (tab.dataset.tab === tabId) {
        tab.classList.remove("border-transparent", "text-gray-500", "hover:text-gray-700", "hover:border-gray-300")
        tab.classList.add("border-indigo-500", "text-indigo-600")
      } else {
        tab.classList.remove("border-indigo-500", "text-indigo-600")
        tab.classList.add("border-transparent", "text-gray-500", "hover:text-gray-700", "hover:border-gray-300")
      }
    })

    // Show/hide panels
    this.panelTargets.forEach(panel => {
      if (panel.dataset.tab === tabId) {
        panel.classList.remove("hidden")
      } else {
        panel.classList.add("hidden")
      }
    })
  }
} 