import {Controller} from "@hotwired/stimulus"
import {enter, leave} from 'el-transition'

export default class extends Controller {
    static targets = ['cart']

    connect() {
        this.cartTarget.addEventListener('click', () => {
            let cartOverlay = document.getElementById('cartOverlay')
            cartOverlay.style.display = 'block'
            enter(cartOverlay)
        })
    }
}