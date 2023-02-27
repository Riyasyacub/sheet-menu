import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slidedown"
export default class extends Controller {
  connect() {
  }
  toggle() {
    let target = this.element.dataset.target;
    $("#"+target).slideToggle();
  }
}
