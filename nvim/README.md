
## 🛠️ Neovim Configuration Setup

This repository includes a full-featured and modular Neovim setup.  
To keep it clean and version-controlled, the config is stored inside the `devops/nvim` directory instead of the default `~/.config/nvim`.

### 🔁 How It Works

We **symlink** the Neovim config back to `~/.config/nvim` so Neovim can still find it, but all changes are tracked inside this repo.

---

### ✅ Setup Steps

```bash
# Step 1: Move your existing Neovim config into this repo
mv ~/.config/nvim ~/path/to/devops/nvim

# Step 2: Create a symlink so Neovim loads from this new location
ln -s ~/path/to/devops/nvim ~/.config/nvim
