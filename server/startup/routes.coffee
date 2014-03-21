module.exports = ->

  # helper functions
  controller = (name) -> require "../controllers/#{name}"
  authenticated = @passport.authenticate('github', failureRedirect: '/login')

  # listing repositories
  @get '/', controller('repos').list
  @get '/ajax/repos/next': controller('repos').next

  # authentication
  @get '/login': controller('sessions').new
  @get '/auth/github': @passport.authenticate('github')
  @get '/auth/github/callback', authenticated, (req, res) -> res.redirect '/'

  # dealing with if a repo is fixed or not
  @get '/ajax/repos/fixed': controller('repos').fixed
  @get '/ajax/repos/notoff': controller('repos').notoff
