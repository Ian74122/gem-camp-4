import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['name']

  greet() {
    // this.element.textContent = "Hello World!"
    const element = this.nameTarget
    const name = element.value
    $("#welcome_message").text(`Hello, ${name}!`)
  }
}
