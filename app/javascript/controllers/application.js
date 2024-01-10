import { Application } from "@hotwired/stimulus"
import { updateFileLabel } from 'controllers/custom';


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
