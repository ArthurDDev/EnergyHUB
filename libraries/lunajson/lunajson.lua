local newdecoder = require 'assets/libraries/lunajson/decoder'
local newencoder = require 'assets/libraries/lunajson/encoder'
local sax = require 'assets/libraries/lunajson/sax'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
	newparser = sax.newparser,
	newfileparser = sax.newfileparser,
}
