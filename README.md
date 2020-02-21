# Rock Paper Scissors

Rock Paper Scissors is a zero sum game that is usually played by two people　using their hands and no tools. The idea is to make shapes with an outstretched　hand where each shape will have a certain degree of power and will lead to an outcome.

## Running it locally
### Prerequisites
_Ruby 2.6_ and _Rails 6_.
### Checking out the code
```
$ git clone https://github.com/atzkey/rps.git
```
### Preparing the environment
```
$ bundle install
```

These steps are sufficient for testing:
```
$ rails test
```

### Starting the development server
Before starting the application up, check that `config.curb_api` option in the Application config is set.

```
$ rails server
```

## Playing the game
Point the browser to http://127.0.0.1:3000 and click on any button to throw a shape of an imaginary hand to play against an imaginary friend.

## TODO
In no particular order:
- [ ] Build the UI parametrically, according to the current ruleset.
- [ ] Update UI in accordance with the mockups.
- [ ] Discuss with the client whether it is better to silently retry, waiting for the next Curb's choice; or should this behaviour be changed to showing an error message to a user instead.
- [ ] Add realtime multiplayer.
- [ ] Add scoreboard.
- [ ] Extract the `Rps` class to a separate gem.
