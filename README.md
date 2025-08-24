# Fennel-Integration-to-Eluna
A lightweight runtime loader that lets you write Eluna scripts in Fennel , a Lua-compiled Lisp. Drop .fnl files into your server and they compile + run automatically. Supports player/creature events, gossip, and Eluna API helpers out of the box.






# 🧠 Fennel for AzerothCore

This project lets you write Eluna scripts for AzerothCore using [Fennel](https://fennel-lang.org/) — a Lisp dialect that compiles to Lua.

I built this just to see if I could. No gameplay reason, no feature request — I just wanted to know: *can you embed a Lisp language into Eluna and make it work?* Turns out, yes. And it’s surprisingly clean.

---

## 🚀 What This Does

- Loads the Fennel compiler (`fennel.lua`) into Eluna
- Exposes Eluna API functions to Fennel scripts
- Dynamically loads all `.fnl` files from a folder
- Supports hot-reloading via `.reload eluna` or `.reload fennel`
- Lets you write WoW server logic in Lisp

---

## 📦 Setup

1. Drop `fennel_loader.lua` and `fennel.lua` into your Eluna script folder.
2. Create a subfolder called `fnl/`
3. Add your Fennel scripts there. Example: `npc_hello.fnl`
4. Reload Eluna: `.reload Eluna`



---

## 🧪 Example: `npc_hello.fnl`

This script makes NPC #75 greet the player and give them a Hearthstone.

```clojure
(do
(local creature-say (. _ENV "creature-say"))
(local player-say (. _ENV "player-say"))
(local player-give-item (. _ENV "player-give-item"))
(local register-gossip-event (. _ENV "register-gossip-event"))

(fn on-hello [event player creature]
 (creature-say creature "Hello, traveler!")
 (player-say player "Thanks for greeting me!")
 (player-give-item player 6948 1)) ;; Hearthstone

(register-gossip-event 75 1 on-hello))


