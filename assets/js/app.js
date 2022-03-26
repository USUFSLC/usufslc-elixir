import "../../deps/phoenix/"
import "../../deps/phoenix_html"

import socket from "./socket"
import StreamChat from "./stream_chat"

window.socket = socket
window.StreamChat = StreamChat

import makeTrongles from "./april-fools"
window.addTrongles = () => makeTrongles(["cubeongle", "pentongle", "quadrongle", "trapezongle", "trongle"].map((x) => `/images/rongles/${x}.png`));
const date = new Date();
if (date.getMonth() === 3 && date.getDate() === 1) {
  // April fools, Trongle!
  window.onload = window.addTrongles;
}

let keyboardString = "";
const trongleListener = (e) => {
  if (e.key === "Enter") {
    if (keyboardString.match(/trongle/)) {
      window.addTrongles();
    }
    keyboardString = "";
  }
  keyboardString += e.key;
}
window.addEventListener("keyup", trongleListener); 