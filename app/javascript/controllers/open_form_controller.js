import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("The 'open_form_controller' is now loaded1")
    console.log(this.formTarget)
  }
  openForm(event) {
    event.preventDefault()
    console.log(event)
    console.log(this.formTarget)
    this.formTarget.classList.toggle("d-none")

  }

}
