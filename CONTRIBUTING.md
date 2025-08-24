# 🤝 Contributing to Fennel-Eluna

Thanks for checking out this project! I built it mostly out of curiosity — to see if Fennel (a Lisp that compiles to Lua) could be integrated into Eluna for AzerothCore. Turns out, it works surprisingly well.

If you’ve got ideas, improvements, bug fixes, or just want to experiment with it, contributions are absolutely welcome.

---

## 🛠 What You Can Contribute

- New examples (branching dialogs, quest logic, mini-games)
- Improvements to the loader or environment setup
- Compatibility fixes for different Lua versions
- Documentation, tutorials, or walkthroughs
- Bug reports or edge case discoveries

---

## 🧪 How to Get Started

1. Fork the repo
2. Clone it locally and make your changes
3. Test your `.fnl` scripts using `.reload eluna` in-game
4. Submit a pull request with a short description of what you added or fixed

---

## 🧼 Code Style

- Keep Fennel scripts clean and idiomatic — use `do`, `fn`, and `local` as needed
- Avoid macros unless you're sure they work with the Lua-only compiler
- Use `. _ENV "function-name"` for Eluna bindings (not `get`, not `["foo"]`)

---

## 💬 Feedback & Issues

If something breaks, or if you have questions about how the loader works, feel free to open an issue. Even if it’s just “this didn’t work and I’m not sure why,” that’s helpful.

---

## 🧠 Philosophy

This project isn’t trying to be a framework or a full rewrite of Eluna — it’s a sandbox for expressive scripting. If you want to push it further, go for it.

Let’s see what Fennel can do in Azeroth.
