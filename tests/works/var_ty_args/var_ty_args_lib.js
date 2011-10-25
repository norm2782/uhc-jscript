varTyArgs = function (myVar) {
  if (typeof(myVar) == "object") {
    document.body.innerHTML += "We have an object!";
  } else if (typeof(myVar) == "string") {
    document.body.innerHTML += "We have a String!";
  } else {
    document.body.innerHTML += "We have something else!";
  }
}
