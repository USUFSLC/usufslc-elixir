import {Socket} from "../../deps/phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

export default socket
