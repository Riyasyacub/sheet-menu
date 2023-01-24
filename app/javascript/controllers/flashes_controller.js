import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  async connect() {
    await sleep(2000)
  }
}


function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}