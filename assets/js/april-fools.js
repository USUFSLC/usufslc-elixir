const randUpTo = (max) => Math.random() * max

const Trongle = (element) => {
  let object = {
    x: Math.floor(randUpTo(window.innerWidth-element.clientWidth)),
    y: Math.floor(randUpTo(window.innerHeight-element.clientHeight)),
    dx: (Math.random() * 2 - 1) * 0.3,
    dy: (Math.random() * 2 - 1) * 0.3,
    width: element.clientWidth,
    height: element.clientHeight,
    lastRender: performance.now()
  };

  object.update = (elapsedTime) => {
    object.x += (object.dx*elapsedTime)
    object.y += (object.dy*elapsedTime)

    object.dx *= object.x + object.width >= window.innerWidth || object.x <= 0 ? -1 : 1;
    object.dy *= object.y + object.height >= window.innerHeight || object.y <= 0 ? -1 : 1;

    object.x = Math.max(0, Math.min(object.x, window.innerWidth-object.width));
    object.y = Math.max(0, Math.min(object.y, window.innerHeight-object.height));
  };

  object.draw = () => {
    element.style.left = `${object.x}px`;
    element.style.top = `${object.y}px`;
  };

  object.loop = (timestamp) => {
    let elapsedTime = timestamp - object.lastRender;
    object.update(elapsedTime);
    object.draw();

    object.lastRender = timestamp;
    requestAnimationFrame(object.loop);
  }

  return object;
};

const makeTrongleElement = (src) => {
  const trongleImage = document.createElement("img");
  trongleImage.style.position = "absolute";
  trongleImage.src = src;
  trongleImage.width = "100";
  trongleImage.height = "100";
  trongleImage.style.left = `-200px`;
  trongleImage.style.top = `-200px`;
  return trongleImage;
}

export default makeTrongles = (trongleSrcs, min=6, max=13) => {
  const numTriangles = Math.floor(Math.random() * (max-min)) + min;
  const trongles = Array(numTriangles).fill(0).map(() => {
    const trongleImage = makeTrongleElement(trongleSrcs[Math.floor(Math.random() * trongleSrcs.length)]);
    document.getElementById("main").appendChild(trongleImage);
    const trongle = Trongle(trongleImage);
    return {trongleImage, trongle};
  });

  requestAnimationFrame((t) => trongles.map(({trongle}) => trongle.loop(t)));
}