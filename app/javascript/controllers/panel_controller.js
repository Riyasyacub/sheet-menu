import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['cart']

    connect() {
        this.cartTarget.addEventListener('click', () => {
            let cartDrawer = document.getElementById('cart-drawer')
            if(cartDrawer.classList.contains('show')) {
                cartDrawer.classList.remove('show')
            }
            else {
                cartDrawer.classList.add('show')
            }
        })
    }
}