<p align="center">
  <img src="https://img.shields.io/badge/R%20NVIM-Custom%20Neovim%20Setup-blueviolet?style=for-the-badge" />
</p>

<h1 align="center">R NVIM — A Modern, Powerful & Animated Neovim Setup</h1>

<p align="center">
A beautifully structured, fast, and feature-rich Neovim configuration built with <b>Lua</b> and powered by <b>Lazy.nvim</b>.  
Designed for developers who want performance, aesthetics, and productivity.
</p>

---

##  Preview (ASCII Dashboard)
```mathematica
RRRRR     N   N    V     V   IIIII   M     M
R    R    NN  N    V     V     I     MM   MM
RRRRR     N N N     V   V      I     M M M M
R   R     N  NN      V V       I     M  M  M
R    R    N   N       V      IIIII   M     M
```

---

#  Features

###  **Custom Animated Dashboard**
- Fully custom-built animated startup screen  
- Aligned menu with icons  
- Smooth header animation  
- Non-scrollable UI  
- Clean centered layout  

###  **Catppuccin Theme**
- Beautiful, soft colors  
- Perfect highlight support  
- Dashboard + UI consistency  

###  **Lazy.nvim Plugin Manager**
- Fast startup  
- Lazy loading  
- Modern plugin management  

###  **Telescope Integration**
- File search  
- Text search  
- Recent files  
- Fuzzy finder everywhere  

###  **Treesitter**
- Advanced syntax highlighting  
- Better indentation  
- Language-aware selection  

###  **LSP + Mason**
- Auto language server installation  
- LSP keymaps  
- Formatting + linting  
- Error diagnostics  

###  **Auto-completion (nvim-cmp)**
- Snippet support via LuaSnip  
- LSP autocompletion  
- Keyword suggestions  

###  **Formatting (null-ls or none-ls)**
- Code formatting  
- Code actions  
- Linting  

###  **Git Integration**
- Git signs in gutter  
- Git hunk preview  
- Git status indicators  

###  **Built-in Terminal Integration**
- Floating terminal  
- Horizontal & vertical terminal openings  
- Auto insert-mode on open  

###  **VSCode-like Keymaps**
- `Ctrl + A` → Select all  
- `Ctrl + C`, `Ctrl + V` → Copy/paste  
- `Ctrl + Z`, `Ctrl + Y` → Undo/Redo  
- Powerful motion + editing shortcuts  

###  **Performance Optimized**
- Lazy loading  
- Low memory usage  
- Instant startup time  
- Clean keymap design  

---

#  Installation

### 1️ **Install Neovim (0.9+ recommended)**

For Arch Linux:

```bash
sudo pacman -S neovim
```

### 2️ Install Git
```bash
sudo pacman -S git
```

### 3️ Install Nerd Font
```zsh
yay -S nerd-fonts-complete
```
### 4️ Clone the R NVIM config
```zsh
git clone https://github.com/ravindran-dev/nvim.git
```
### 5️ Open Neovim
```zsh
nvim
```
Lazy.nvim will automatically install all plugins.

# Folder Structure
```yaml
~/.config/nvim
├── init.lua
├── lua
│   ├── core
│   │   ├── keymaps.lua
│   │   ├── options.lua
│   │   ├── lazy.lua
│   │   ├── dashboard.lua
│   ├── plugins
│   │   ├── treesitter.lua
│   │   ├── lsp.lua
│   │   ├── cmp.lua
│   │   ├── null-ls.lua
│   │   ├── telescope.lua
│   │   ├── ui.lua
|   |── lsp
|   |   |── configs.lua
|   |── utils.lua
└── README.md
```

# Keymaps (Important)
### Shortcut	Action
- Ctrl + A	Select All
- Ctrl + C	Copy
- Ctrl + V	Paste
- Ctrl + Z	Undo
- Ctrl + Y	Redo
- Space + f	File Finder
- Space + g	Live Grep
- Space + e	Toggle Explorer
- Space + t	Open Terminal
- Space + l	Lazy Menu
- q	Quit Dashboard

# Plugins Used

- Lazy.nvim – plugin manager

- Catppuccin – color scheme

- Telescope – fuzzy finder

- Treesitter – syntax engine

- LSPConfig – language server support

- Mason – language server installer

- nvim-cmp – completion

- LuaSnip – snippets

- null-ls – formatting/linting

- gitsigns.nvim – git decorations

- nvim-tree or neo-tree – file explorer

- toggleterm.nvim – terminal manager
# Contributing

Contributions are welcome!
Open an issue or create a pull request.

# License

This project is licensed under the MIT License.

#  Author - **Ravindran S** 


Developer • ML Enthusiast • Neovim Customizer • Linux Power User  

Hi! I'm **Ravindran S**, an engineering student passionate about:

-  Linux & System Engineering  
-  AIML (Artificial Intelligence & Machine Learning)  
-  Full-stack Web Development  
-  Hackathon-grade project development  

R NVIM is my personal Neovim distribution - built to be fast, beautiful, and productive.

---

# 🔗 Connect With Me

You can reach me here:

###  **Social**
- [**GitHub**](https://github.com/ravindran-dev)
- [**LinkedIn**](www.linkedin.com/in/ravindran-s-982702327)


###  **Contact**
- Email: **ravindrans.dev@gmail.com**
