# nix-darwin
Configuration of my MacOS machines via Nix

# Commands run to setup Nix

Firstly, installed Nix via the recommended way [here](https://nixos.org/download/).

Then, installed `nix-darwin` with `flakes` as defined in the repository [here](https://github.com/LnL7/nix-darwin?tab=readme-ov-file#flakes)

Slightly modified the commands because of the experimental nature of `flakes`:

```bash
nix flake init -t nix-darwin --experimental-features 'nix-command flakes'
```

And:

```bash
nix run nix-darwin --experimental-features 'nix-command flakes' -- switch --flake ~/.config/nix-darwin
```
