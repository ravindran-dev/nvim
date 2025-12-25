<p align="center">
  <img src="https://img.shields.io/badge/R%20NVIM-Custom%20Neovim%20Setup-blueviolet?style=for-the-badge" />
</p>

<h1 align="center">R NVIM - A Modern, Powerful & Animated Neovim Setup</h1>

<p align="center">
A beautifully structured, fast, and feature-rich Neovim configuration built with <b>Lua</b> and powered by <b>Lazy.nvim</b>.  

</p>



##  Preview
```mathematica
     ██████╗     ███╗   ██╗██╗   ██╗██╗███╗   ███╗
     ██╔══██╗    ████╗  ██║██║   ██║██║████╗ ████║
     ██████╔╝    ██╔██╗ ██║██║   ██║██║██╔████╔██║
     ██╔══██╗    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
     ██║  ██║    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
     ╚═╝  ╚═╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
```



##  Features

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

###  **Auto-completion**
- Snippet support via LuaSnip  
- LSP autocompletion  
- Keyword suggestions  

###  **Formatting**
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



##  Installation

### 1️ **Install Neovim**

For Arch Linux:

```zsh
sudo pacman -S neovim
```

### 2️ Install Git
```zsh
sudo pacman -S git
```

### 3️ Install Nerd Font
```zsh
sudo pacman -S nerd-fonts
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

## Folder Structure
```yaml
~/.config/nvim
├── Session.vim
├── init.lua
├── LICENSE
├── README.md
├── SECURITY.md
├── lua
│   ├── core
│   │   ├── lazy.lua                
│   │   ├── dashboard.lua           
│   │   ├── options.lua             
│   │   ├── keymaps.lua             
│   │   ├── weather.lua             
│   │   ├── leetcode_cookie.lua   
│   │   ├── leetcode_browser.lua    
│   │   ├── autocomds.lua           
│   │   ├── configs.lua
|   |   ├── support.lua
|   |   ├── plugin_search.lua
|   |   ├── tree.lua
|   |   ├── system.lua       
│   ├── scripts
│   │   ├── get_leetcode_cookie.py  
│   ├── utils.lua                   
│   ├── plugins
│       ├── lsp.lua                
│       ├── cmp.lua                 
│       ├── telescope.lua           
│       ├── treesitter.lua          
│       ├── null-ls.lua             
│       ├── git.lua                 
│       ├── git-blame.lua          
│       ├── persistence.lua         
│       ├── ui.lua                 
│       ├── leetcode.lua            
│       ├── iron.lua
```

## Keymaps (Important)
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
- q	        Quit Dashboard
- Space + ? Support popup

## Plugins Used

 - Lazy.nvim - modern plugin manager
  
 - Catppuccin - color scheme & UI theme
  
 - telescope.nvim - fuzzy file and text finder
  
 - nvim-treesitter - advanced syntax parser
  
 - nvim-lspconfig - language server support
  
 - Mason - auto-installation of LSPs
  
 - mason-lspconfig - LSP auto-wiring
  
 - nvim-cmp - auto-completion engine
  
 - LuaSnip - snippet engine
  
 - null-ls - formatting & linting
  
 - gitsigns - git change visualization
  
 - git-blame.nvim - inline git line blame
  
 - Persistence.nvim - auto session restore
  
 - toggleterm.nvim - floating & split terminals
  
 - nvim-tree - file explorer
  
 - LeetCode.nvim - solve Leetcode inside Neovim
  
 - nvim-web-devicons - developer icons
  
 - Bufferline.nvim - tab-like buffer view
  
 - Lualine.nvim - bottom statusline
  
 - Plenary.nvim - base library for plugins
  
 - nvim-notify - stylish notifications
   
 - Vigemus/iron.nvim - Adds a REPL panel for Python, Node, Bash, Lua and sends code live to terminal.

-  MunifTanjim/nui.nvim - UI component library powering popups and advanced layout windows.

-  nvim-lualine/lualine.nvim - Status line plugin used for displaying breadcrumbs & system stats.

-  kyazdani42/nvim-web-devicons - Icon pack for the dashboard, menu icons, and file types.

-  SmiteshP/nvim-navic - Provides breadcrumb navigation and an outline sidebar for code structure.
  
## Additional Features

- Live clock + date display on dashboard

- Weather display

- Git status overview

- Launch stats showing plugin count & load time

- Browser-based LeetCode login (no manual cookies) (Under issues)

- Integrated LeetCode problem navigation, test & submit

- Session restore with one click

- Responsive, highlighted dashboard menu navigation

- Global VSCode-like keymaps

- Line numbers & relative line numbers enabled by default

- Improved non-scrollable fixed dashboard layout

- Dashboard message changes based on morning, afternoon, evening, or late night usage.

- <leader>dd - Jump to the dashboard immediately from anywhere in Nvim.

- Shows live CPU inside the dashboard.

- Displays Neovim’s current Lua memory usage

- Quick search through installed plugins directly from the dashboard menu.

- Folder info in dashboard

- Support popup which lists all the shortcuts to use the R NVIM (<leader> + ?)

## R NVIM UI example:



<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/52dd7b8d-5a52-4945-852f-12e7d9f318f6" />





## Contributing

Contributions are welcome!
Open an issue or create a pull request.

## License

This project is licensed under the MIT License.

##  Author - **Ravindran S** 


Developer • ML Enthusiast • Neovim Customizer • Linux Power User  

Hi! I'm **Ravindran S**, an engineering student passionate about:

-  Linux & System Engineering  
-  AIML (Artificial Intelligence & Machine Learning)  
-  Full-stack Web Development  
-  Hackathon-grade project development  

R NVIM is my personal Neovim distribution - built to be fast, beautiful, and productive.



## 🔗 Connect With Me

You can reach me here:

###  **Socials**
<a href="www.linkedin.com/in/ravindran-s-982702327" target="_blank">
  <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white">
</a>


<a href="https://github.com/ravindran-dev" target="_blank">
  <img src="https://img.shields.io/badge/GitHub-111111?style=for-the-badge&logo=github&logoColor=white">
</a>


###  **Contact**
<a href="mailto:ravindrans.dev@gmail.com" target="_blank">
  <img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white">
</a>
