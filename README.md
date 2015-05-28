#hookly-rails

1. Ruby wrapper for the Hookly API
2. hookly.js asset pipeline provider/wrapper

Rails 3.1+ asset-pipeline gem to provide hookly.js

#Setup

Add to your Gemfile:

```ruby
gem 'hookly-rails'
```

###JS Setup
Then add this to you application.js manifest:

```javascript
//= require hookly
```

Then check out the [hookly.js docs](https://github.com/bnorton/hookly.js) for usage and working examples

###API Setup

```ruby
# config/initializers/hookly.rb
Hookly.token = '{{token}}'
Hookly.secret = '{{secret}}'
```

###Post a message to the #updates channel

In the client javascript subscribe to '#updates'
```javascript
hookly.setup('{{token}}')
hookly.on('#updates', function(options) {
  // options == { model: 'Message', id: 5, text: 'Thanks for the info.' }
});
```

Push a new message the updates channel
```ruby
Hookly::Message.create('#updates', model: 'Message', id: 5, text: 'Thanks for the info.')
 #=> #<Hookly::Message id: '44fjwq-djas' slug: '#updates', data: { model: 'Message', id: 5, text: 'Thanks for the info.' }>
```

###Post a **private** message

Have information that only a certain user should see??

Include a unique user id on the client and server

```javascript
hookly.setup('{{token}}', '{{uid}}')
hookly.on('#updates', function(options) {
  // options == { model: 'Message', id: 6, text: 'Thanks for the PRIVATE info.' }
});
```

```ruby
Hookly::Message.create('#updates', '{{uid}}', id: 6, text: 'Thanks for the PRIVATE info.')
 #=> #<Hookly::Message id: '44fjwq-djas' slug: '#updates', uid: '{{uid}}' data: { model: 'Message', id: 6, text: 'Thanks for the PRIVATE info.' }>
```


<!--- Not yet implemented
###Message buffering / caching
A channel can be setup to buffer messages and deliver them when a user comes online.
Simply create a buffered channel, messages will be cached for 60 minutes following their receipt
```ruby
Hookly::Channel.create(buffer: 3600)
```
-->
