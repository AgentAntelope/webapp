GitHub = require '../github'
async = require 'async'
Repo = require '../models/repo'
_ = require 'lodash'

module.exports =
  list: (req, res) ->
    if req.user?
      res.render 'repos/list'
    else
      res.redirect '/login'
  next: (req, res) -> GitHub.next (repo) -> res.send repo
  fix: (req, res) ->
    res.end()
    Repo.find(where: _.pick(req.body, 'name', 'owner')).success (repo) ->
      repo.updateAttributes
        fixer: req.user?.username
        status: if req.body.offensive then 'fixed' else 'fix not needed'
  count: (req, res) ->
    Repo.displayCounts (counts) -> res.send counts
