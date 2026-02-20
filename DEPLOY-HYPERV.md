# VM NixOS avec Accélération GPU (Hyper-V + GPU-PV)

## ✅ Configuration réussie

Votre VM NixOS est configurée avec :
- **8 GB** de RAM
- **4 CPU** virtuels
- **80 GB** de disque (VHDX dynamique)
- **Accélération GPU-PV** activée
- Boot depuis l'ISO NixOS 24.11

## 🚀 Démarrage de la VM

### Méthode 1 : Script automatique (Recommandé)
Double-cliquez sur : `start-hyperv.bat`

### Méthode 2 : PowerShell
```powershell
Start-VM -Name NixOS
vmconnect localhost NixOS
```

### Méthode 3 : Interface graphique
1. Ouvrez le Gestionnaire Hyper-V : `virtmgmt.msc`
2. Double-cliquez sur la VM "NixOS"

## 🎮 Configuration NixOS pour utiliser le GPU

Une fois NixOS installé, ajoutez à votre configuration (`/etc/nixos/configuration.nix`) :

```nix
{ config, pkgs, ... }:

{
  # Activer le support GPU Intel
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver  # Pour Intel Arc/iGPU
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime  # Pour OpenCL
    ];
  };

  # Chargement des modules kernel pour le GPU
  boot.kernelModules = [ "i915" ];
  
  # Variables d'environnement pour l'accélération matérielle
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";  # ou "i965" selon votre GPU
  };

  # Installer des outils de test GPU
  environment.systemPackages = with pkgs; [
    glxinfo
    vulkan-tools
    mesa-demos
    intel-gpu-tools
  ];
}
```

Puis reconstruisez :
```bash
sudo nixos-rebuild switch
```

## 🧪 Tester l'accélération 3D

Dans la VM, exécutez :

```bash
# Vérifier OpenGL
glxinfo | grep "OpenGL renderer"

# Tester Vulkan
vulkaninfo

# Test visuel
glxgears

# Informations GPU Intel
intel_gpu_top
```

## 📊 Informations GPU actuelles

Votre système hôte a **2 GPU Intel** compatibles GPU-PV :
- Intel GPU 1 (PCI VEN_8086&DEV_643E)
- Intel GPU 2 (PCI VEN_8086&DEV_64A0)

Chaque GPU peut être partitionné en **32 partitions virtuelles**.

## 🔧 Commandes utiles

### Arrêter la VM
```powershell
Stop-VM -Name NixOS
```

### Vérifier l'état
```powershell
Get-VM -Name NixOS
```

### Voir la configuration GPU
```powershell
Get-VMGpuPartitionAdapter -VMName NixOS
```

### Modifier les ressources
```powershell
# Changer la RAM
Set-VM -Name NixOS -MemoryStartupBytes 16GB

# Changer les CPU
Set-VM -Name NixOS -ProcessorCount 8
```

## ⚠️ Notes importantes

1. **Privilèges administrateur** requis pour démarrer les scripts
2. Le GPU-PV nécessite que l'hôte Windows utilise aussi le GPU (ne pas désactiver l'affichage)
3. Pour de meilleures performances, désactivez l'économiseur d'écran Windows pendant l'utilisation de la VM
4. Les pilotes GPU Intel doivent être à jour sur l'hôte Windows

## 🆚 Comparaison QEMU vs Hyper-V

| Fonctionnalité | QEMU (WHPX) | Hyper-V (GPU-PV) |
|----------------|-------------|------------------|
| Accélération 3D | Logicielle (virgl) | Matérielle (GPU-PV) |
| Performance GPU | Limitée | Native |
| Configuration | Simple | Moyenne |
| Support Vulkan | Limité | Complet |
| Support OpenCL | Non | Oui |

## 📁 Fichiers

- `nixos-disk.vhdx` : Disque virtuel (80 GB)
- `nixos-24.11.iso` : ISO d'installation
- `start-hyperv.bat` : Script de démarrage rapide
- `start-hyperv.ps1` : Script PowerShell détaillé
- `setup-hyperv-gpu.ps1` : Script de configuration initiale

---

**VM créée le :** 2025-12-16  
**GPU-PV :** ✅ Activé  
**Status :** Prêt pour l'installation
