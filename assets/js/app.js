// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import topbar from "topbar"
import {LiveSocket} from "phoenix_live_view"

let Hooks = {}
Hooks.Clicky = {
    mounted(){
        this.el.addEventListener('mousedown', e => {
            let data = e.currentTarget.dataset
            if (e.button === 2) {
                this.pushEvent("paint_cell_secondary_color", data);
            } else {
                this.pushEvent("paint_cell_primary_color", data);
            }
        });
        this.el.addEventListener('mouseover', e => {
            let data = e.currentTarget.dataset
            if (e.buttons === 2) {
                this.pushEvent("paint_cell_secondary_color", data);
            } else if (e.buttons === 1) {
                this.pushEvent("paint_cell_primary_color", data);
            }
        });
    }
}
Hooks.ColorPick = {
    mounted(){
        this.el.addEventListener('mousedown', e => {
            if (e.button === 2) {
                this.pushEvent("set_secondary_color", e.currentTarget.dataset.color);
            } else {
                this.pushEvent("set_primary_color", e.currentTarget.dataset.color);
            }
        });
    }
}
Hooks.DragWindow = {
    mounted(){
        // Modal window code DONT TOUCH!
        /*
        this.el.addEventListener('mousedown', e => {
            let shiftX = e.clientX - this.el.getBoundingClientRect().left;
            let shiftY = e.clientY - this.el.getBoundingClientRect().top;
            let move = e => {
                this.el.style.left = e.pageX - shiftX + 'px';
                this.el.style.top = e.pageY - shiftY + 'px';
            }
            this.el.addEventListener('mousemove', move);
            this.el.addEventListener('mouseup', e => {
                this.el.removeEventListener('mousemove', move);
                this.el.onmouseup = null;
            });
        });
        */
    }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket(
    "/live",
    Socket,
    {
        hooks: Hooks,
        params: {
            _csrf_token: csrfToken
        }
    })

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

