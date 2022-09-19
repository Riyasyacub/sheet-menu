import {Controller} from "@hotwired/stimulus"
import {enter, leave} from 'el-transition'

export default class extends Controller {
    static targets = ['menuButton', 'openIcon', 'closeIcon', 'mobileMenu']

    connect() {
        this.menuButtonTarget.addEventListener('click', () => {
            if (this.mobileMenuTarget.classList.contains('hidden')){
                this.mobileMenuTarget.classList.remove('hidden')
                this.openIconTarget.classList.add('hidden')
                this.closeIconTarget.classList.remove('hidden')
            }
            else{
                this.mobileMenuTarget.classList.add('hidden')
                this.openIconTarget.classList.remove('hidden')
                this.closeIconTarget.classList.add('hidden')
            }
        })
    }
}
