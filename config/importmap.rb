# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "alpinejs", to: "https://ga.jspm.io/npm:alpinejs@3.13.3/dist/module.esm.js"
pin_all_from "app/javascript/controllers", under: "controllers"
