import { Controller } from "@hotwired/stimulus"
import { enter, leave } from 'el-transition'

export default class extends Controller {
    static targets = ['openButton','closeButton','mobileMenu']
    connect() {
        this.openButtonTarget.addEventListener('click', () => {
            enter(this.mobileMenuTarget)
        })
        this.closeButtonTarget.addEventListener('click', () => {
            leave(this.mobileMenuTarget)
        })
    }
}
