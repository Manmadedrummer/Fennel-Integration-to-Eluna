# 🧠 Fennel Integration for Eluna
[![Eluna](https://img.shields.io/badge/Eluna-Scripting-blue?logo=lua)](https://github.com/azerothcore/eluna)
[![Fennel](https://img.shields.io/badge/Fennel-Lisp%20for%20Lua-green?logo=lisp)](https://fennel-lang.org)
[![AzerothCore](https://img.shields.io/badge/AzerothCore-WoW%20Server-red?logo=worldofwarcraft)](https://github.com/azerothcore/azerothcore-wotlk)


A lightweight runtime loader that lets you write Eluna scripts in [Fennel](https://fennel-lang.org/) — a Lisp dialect that compiles to Lua.

Drop `.fnl` files into your server and they compile + run automatically. Supports player/creature events, gossip, and Eluna API helpers out of the box.

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
4. Reload Eluna: `.reload eluna`
5. *(Optional)* If your loader registers a player-login hook, logging in will auto-run all `.fnl` files.

---

# 📁 Project Structure

| File/Folder        | Description                                      |
|-------------------|--------------------------------------------------|
| `fennel_loader.lua` | Main loader that bootstraps Fennel into Eluna   |
| `fennel.lua`        | The Fennel compiler (Lua-only version)         |
| `fnl/`              | Folder for all your Fennel scripts             |

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
```

## 🔧 How the Loader Works (high level)

- Loads `fennel.lua` and keeps its API table (no `install()` call needed)  
- For each `.fnl` file:  
  1. Reads source  
  2. `compileString` → Lua  
  3. `load` the compiled Lua with a custom `_ENV` that includes Eluna helpers  
  4. Executes the chunk  

This lets `.fnl` scripts call Eluna exactly like Lua does.


## ❤️ Credits

- [Fennel](https://fennel-lang.org) — Lua-compiled Lisp  
- [Eluna](https://github.com/azerothcore/eluna) — WoW scripting API  
- Built for curiosity and fun 




