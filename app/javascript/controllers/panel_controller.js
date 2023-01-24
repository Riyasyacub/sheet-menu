import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

    open() {
        let cartDrawer = $('#cart-drawer')
        cartDrawer.addClass('show')
        $(".overlay").addClass('show')
        $(".pane").addClass('right--100')
    }

    close() {
        let cartDrawer = $('#cart-drawer')
        cartDrawer.removeClass('show')
        $(".overlay").removeClass('show')
        $(".pane").removeClass('right--100')
    }
}