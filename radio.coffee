util   = require 'util'
colors = require 'colors'
mpg    = require 'mpg123'

radio_stations =
	"synth"     : "http://streaming.radionomy.com/DRIVE"
	"rasta"     : "http://ais.rastamusic.com/rastamusic.mp3"
	"synth2"    : "http://stream.radio.co/s98f81d47e/listen"
	"reggae"    : "http://50.22.212.194:8177/"
	"dubstep"   : "http://ice1.somafm.com/dubstep-256-mp3"
	"ert3"      : "http://radiostreaming.ert.gr/ert-958fm"
	"deephouse" : "http://77.92.76.134:8525/"
	"enlefko"   : "http://206.190.150.92:8301"

RADIO =

	listRadioStations: (options)->

		console.log radio_stations

	_showInfo: (options)->

		player = options.player
		info = "[ STATION: %s ][ TRACK: %s ][ VOL: %s% ]"
		`process.stdout.write('\033c')`	# RESET TERMINAL SCREEN
		color = if player._isPlaying then "green" else "red"
		console.log util.format(info, player._currentStation, player.track, player._volume)[color]

	play: (options)->

		player = new mpg.MpgPlayer()
		player._isPlaying      = false
		player._volume         = 100
		player._currentStation = options.station

		process.stdin.setRawMode( true )
		process.stdin.setEncoding('utf8')
		process.stdin.on 'readable', ->
			chunk = process.stdin.read()
			switch
				when chunk is " "
					if player._isPlaying
						player.pause()
						player._isPlaying = false
					else
						player.play(player.file)
						player._isPlaying = true
				when chunk is "q"
					player.close()
					process.exit()
				when chunk is "-"
					if player._volume > 0
						player._volume = player._volume - 5
						player.volume(player._volume)
				when chunk is "="
					if player._volume <= 100
						player._volume = player._volume + 5
						player.volume(player._volume)
				else
					console.log "Unknown command", chunk
			RADIO._showInfo({ player: player })

		player.play( radio_stations[options.station] )
		player._isPlaying = true
		RADIO._showInfo({ player: player })

module.exports = RADIO

