{ config, pkgs, ... }:

{
  # Service SSH (OpenSSH)
  services.openssh = {
    enable = true;

    settings = {
      # Sécurité : désactiver la connexion root par mot de passe
      PermitRootLogin = "prohibit-password";

      # Permettre l'authentification par mot de passe (à désactiver si vous utilisez des clés SSH)
      PasswordAuthentication = true;

      # Désactiver l'authentification par clé publique vide
      PubkeyAuthentication = true;

      # Désactiver X11 forwarding (sécurité)
      X11Forwarding = false;
    };

    # Port par défaut (22)
    ports = [ 22 ];
  };

  # Ouvrir le port SSH dans le firewall
  networking.firewall.allowedTCPPorts = [ 22 ];
}
