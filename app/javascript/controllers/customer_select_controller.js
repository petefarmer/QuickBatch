import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.keySelect = document.getElementById('sales_order_customer_key')
    this.nameSelect = document.getElementById('sales_order_customer_name')
    
    // Handle change events
    this.keySelect.addEventListener('change', (e) => {
      const customerId = e.target.value
      if (customerId) {
        this.nameSelect.value = customerId
        this.nameSelect.dispatchEvent(new Event('change'))
      } else {
        this.nameSelect.value = ''
        this.nameSelect.dispatchEvent(new Event('change'))
      }
    })

    this.nameSelect.addEventListener('change', (e) => {
      const customerId = e.target.value
      if (customerId) {
        this.keySelect.value = customerId
        this.keySelect.dispatchEvent(new Event('change'))
      } else {
        this.keySelect.value = ''
        this.keySelect.dispatchEvent(new Event('change'))
      }
    })
  }

  updateCustomerName(event) {
    const customerId = this.keySelect.value
    if (customerId) {
      this.nameSelect.value = customerId
      this.nameSelect.dispatchEvent(new Event('change'))
    } else {
      this.nameSelect.value = ''
      this.nameSelect.dispatchEvent(new Event('change'))
    }
  }

  updateCustomerKey(event) {
    const customerId = this.nameSelect.value
    if (customerId) {
      this.keySelect.value = customerId
      this.keySelect.dispatchEvent(new Event('change'))
    } else {
      this.keySelect.value = ''
      this.keySelect.dispatchEvent(new Event('change'))
    }
  }
} 