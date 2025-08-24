(do
  ;; Bind Eluna functions from _ENV
  (local creature-say (. _ENV "creature-say"))
  (local player-say (. _ENV "player-say"))
  (local player-give-item (. _ENV "player-give-item"))
  (local register-gossip-event (. _ENV "register-gossip-event"))

  ;; Define gossip handler
  (fn on-hello [event player creature]
    (creature-say creature "Hello, traveler!")
    (player-say player "Thanks for greeting me!")
    (player-give-item player 6948 1)) ;; Hearthstone

  ;; Register gossip event
  (register-gossip-event 75 1 on-hello))
