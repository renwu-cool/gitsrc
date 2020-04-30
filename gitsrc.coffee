#!/usr/bin/env coffee

klawSync = require('klaw-sync')
fs = require 'fs'
path = require 'path'


log = ->
  process.stdout.write Array.from(arguments).join(' ')

src = (gitpath)=>
  config = fs.readFileSync(
    path.join(gitpath,'config'),"utf-8"
  )
  log /url\s*=\s*(.*)/.exec(config)[1]

do =>
  cwd = process.cwd()
  while true
    gitpath = path.join(cwd,'.git')
    cwd = path.dirname(cwd)
    while true
      try
        st = fs.statSync(gitpath)
      catch err
        break
      if st.isFile()
        txt = fs.readFileSync gitpath,'utf-8'
        src path.resolve(
          path.dirname(gitpath)
          /gitdir\s*:\s*(.*)/.exec(txt)[1]
        )
        return
      else if st.isDirectory()
        src gitpath
        return
      break
    if cwd == "/"
      break
  process.exit()

