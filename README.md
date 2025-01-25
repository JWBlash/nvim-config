# neovim config

i mean yeah its just a neovim config dir

### `.editorconfig`

this config leverages an `~/.editorconfig` file.

here's mine so far:

```bash
[*.lua]
indent_style = space
indent_size = 2

[*.go]
indent_style = space
indent_size = 4
```

let's see if i remember to update it as time goes on!

---

### TODO

- I can probably just sync `~/.editorconfig` in `init.lua`
- Since I use this with git, I can probably also fetch on start and warn if behind main

