acceptsNArgs = function() {
  document.writeln("acceptsNArgs function was called <br />");
  document.writeln("number of arguments: " + arguments.length);
  for( var i = 0; i < arguments.length; i++ ) {
    document.writeln( 'Argument-' + i + ': ' + arguments[ i ] + '<br />' );
  }
}
