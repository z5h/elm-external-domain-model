# elm-external-domain-model
A sample Elm app where the domain data lives outside of the Elm app (e.g. a database over a network).

# Domain model operations
Domain.elm contains the domain model. It is opaque. We can call a function (e.g. `incr`) and get a `Diff` back. The only thing we should be able to do to a `Diff` is to convert it to a `Cmd`. Here we do that via Ports. The premise is to say "hey Elm runtime, I wish this diff was applied against my model".

# Domain model updates
We use a subscription to listen for domain model updates. These updates are also opaque. They can be applied to the domain model to update it.

# app update & subscriptions
The app's main update function deals with UI events, and also with the subscriptions, helps shuttle messages/commands between the domain model and it's external representation.
