{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- ÉDITEURS & IDE ---
    neovim         # Éditeur de texte moderne

    # --- GESTION DE CODE ---
    git            # Contrôle de version
    gh             # CLI GitHub officiel

    # --- NIX TOOLS ---
    nixpkgs-fmt    # Formateur de code Nix
  ];
}
