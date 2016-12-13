#!/bin/sh

###
exec coffee $0 "$@"
###

token = "cb561cb3cd0ddff31551f4b49608639e56aad80d"

nowId = (new Date).getTime()

api = "http://c.n9.vc/app/screen"


request = require('request');

getOne = ()->

  request(
    method: 'GET'
    uri: api
    qs:
      token: token
      l: 1
      s: nowId.toString()
    json: true
  , (err, res, body)->
    if(!err)
      for m in body
        nowId = m.id + 1 if m.id + 1 > nowId
        msg = if m.s 
          1
        else
          0
        msg += m.m + "\n" 
        process.stdout.write(msg)
    process.nextTick getOne
  )

getOne()
