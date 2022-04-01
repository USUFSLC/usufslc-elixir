import "../../deps/phoenix/"
import "../../deps/phoenix_html"

import socket from "./socket"
import StreamChat from "./stream_chat"

window.socket = socket
window.StreamChat = StreamChat

import makeTrongles from "./april-fools"
window.addTrongles = () => makeTrongles([...["doritongle", "tuxongle", "cubeongle", "pentongle", "quadrongle", "trapezongle", "trongle", "trongHandsome", "trongYeah", "trongPoly", "trongFem", "trongAngry", "LegTrong2", "trongPants2", "trongPants"].map((x) => `/images/rongles/${x}.png`), "/images/rongles/tronglePat.gif"]);
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
