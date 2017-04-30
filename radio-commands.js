// Generated by CoffeeScript 1.12.4
var colors, initCommands;

colors = require('colors');

initCommands = function(program) {
  return program.command('radio').description('Streaming Radio').option('--play <genre>', '').option('--list', 'List available radio stations').action(function(options) {
    var RADIO;
    RADIO = require('./radio');
    if (options.list) {
      RADIO.listRadioStations();
    }
    if (options.play) {
      return RADIO.play({
        station: options.play
      });
    }
  });
};

module.exports = initCommands;