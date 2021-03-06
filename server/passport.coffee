require('node-env-file')("#{__dirname}/.env")

passport = require 'passport'
GitHubStrategy = require('passport-github').Strategy

# since there is currently no database,
# user serialization is unimplemented.
passport.serializeUser (user, done) -> done null, user
passport.deserializeUser (obj, done) -> done null, obj

passport.use new GitHubStrategy
  clientID: process.env.GITHUB_CLIENT_ID
  clientSecret: process.env.GITHUB_CLIENT_SECRET
  callbackURL: "http://#{process.env.HOSTNAME}:#{process.env.PORT}/auth/github/callback"
, (accessToken, refreshToken, profile, done) ->
  # database stuff would happen here if we had a database
  # instead, just return the stuff that GitHub sends
  done null, profile

module.exports = passport
