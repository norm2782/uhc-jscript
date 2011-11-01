function some_function(arg1, arg2, callback) {
  var my_number = Math.ceil(Math.random() * (arg1 - arg2) + arg2);
  callback(my_number);
}
