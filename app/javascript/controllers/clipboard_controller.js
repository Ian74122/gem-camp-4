import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["email"]
  copy() {
    var copyText = this.emailTarget.textContent
    navigator.clipboard.writeText(copyText).then(() => {
      // Alert the user that the action took place.
      // Nobody likes hidden stuff being done under the hood!
      alert("Copied to clipboard");
    });
  }
}