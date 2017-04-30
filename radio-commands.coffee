colors = require 'colors'

initCommands = (program)->

	program
		.command('radio')
		.description('Streaming Radio')
		.option('--play <genre>', '')
		.option('--list', 'List available radio stations')
		.action (options) ->

			RADIO = require('./radio')

			if options.list

				RADIO.listRadioStations()

			if options.play

				RADIO.play({ station: options.play })

module.exports = initCommands