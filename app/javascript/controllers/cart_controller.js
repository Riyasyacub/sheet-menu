import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['addToCart']

    connect() {
        // if (localStorage.getItem('cart') == null) {
        //     localStorage.setItem('cart', '{}')
        // }
        this.addToCartTarget.addEventListener('click', () => {
            let item_id = this.addToCartTarget.id.split('-')[1]
            let qty = parseInt(document.getElementById('qty-' + item_id).value)
            // let cart = JSON.parse(localStorage.getItem('cart'))
            qty = qty >= 0 ? qty : 0
            fetch('/cart/add/'+ item_id + '?qty='+qty )
                .then((response) => response.json())
                .then((data) => console.log(data));
            // cart[item_id] = qty
            // localStorage.setItem('cart', JSON.stringify(cart))
            // console.log(JSON.parse(localStorage.getItem('cart')))
        })

        // this.openCartTarget.addEventListener('click', () => {
        //     let cartDrawer = document.getElementById('cart-drawer')
        //     if (cartDrawer.classList.contains('show')) {
        //         cartDrawer.classList.remove('show')
        //     }
        //     else {
        //         cartDrawer.classList.add('show')
        //     }
        // })

    }
}
