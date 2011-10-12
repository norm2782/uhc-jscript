function Book() {}

function mkBook() {
  return new Book();
}

function getL(attr, obj) {
  return obj[attr];
}

function setL(attr, val, obj) {
  obj[attr] = val;
  return obj;
}

function modL(attr, f, obj) {
  // TODO: Is this the right way to apply a function from Haskell? Probably not...
  obj[attr] = f.__evN__(obj[attr]);
  return obj;
}
