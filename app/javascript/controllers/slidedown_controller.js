import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slidedown"
export default class extends Controller {
  connect() {
    console.log("connected")
  }
  toggle() {
    console.log("toggle")
    let target = this.element.dataset.target;
    $("#"+target).slideToggle();
  }
}
