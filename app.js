var app = Elm.App.embed(document.querySelector("#elm-program"));

var model = 0;

// simulate delay of loading external resource
setTimeout(function(){
    app.ports.incomingDomainUpdate.send(model);
}, 2000);


app.ports.outgoingDomainUpdate.subscribe(function(value){
    // we get an update
    if (value.pre == model) {
      model = model + 1;
      app.ports.incomingDomainUpdate.send(value.post);
    }
});
