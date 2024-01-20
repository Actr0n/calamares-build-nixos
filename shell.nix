{ pkgs ? import <nixpkgs>{} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [
      #Insert packages here.
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          ms-vscode.cpptools
        ];
      })
      git
      libsForQt5.qt5.qtwayland
    ];
    shellHook = ''
      export QT_QPA_PLATFORM=wayland

      nohup env GNOME_SHELL_SLOWDOWN_FACTOR=2 MUTTER_DEBUG_DUMMY_MODE_SPECS=1024x768 dbus-run-session -- gnome-shell --nested --wayland &
      
      code calamares
    '';
}
