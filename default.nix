with import <nixpkgs> {};

stdenv.mkDerivation rec {
   name = "calamares";

   dontWrapQtApps = true;

   src = ./calamares;

	nativeBuildInputs = with pkgs; [ cmake ninja ];

	buildInputs = with pkgs; [
      gettext
      libatasmart
      icu
      parted
      libsForQt5.appstream-qt
      libsForQt5.polkit-qt
      libsForQt5.qt5.qtsvg
      #libsForQt5.qt5.qtwebkit
      libsForQt5.qt5.qtdeclarative
      libsForQt5.qt5.qttools
      libsForQt5.kpmcore
      libsForQt5.qt5.qtwebengine
      libsForQt5.kwidgetsaddons
      libsForQt5.qt5.qtbase
      libsForQt5.kconfig
      libsForQt5.ki18n
      libsForQt5.kcoreaddons
      python311Packages.boost
      python311Packages.libpwquality
      libyaml
      os-prober
      pkg-config-unwrapped
      python3
      yaml-cpp
      extra-cmake-modules
      libxcrypt
	];

   configurePhase = ''
     mkdir -p $out/bin
	  cmake -S . -B $out/build -G Ninja
   '';

   buildPhase = ''
	  ninja -C $out/build
    '';

   #preInstallPhase = ''
	#  mkdir -p $out/etc/calamares
	#  ln -s $out/build/settings.conf $out/etc/calamares/settings.conf

	#  mkdir -p $out/usr/share/calamares
	#  ln -s $out/build/src/qml $out/usr/share/calamares/qml

	#  mkdir -p $out/etc/calamares/branding
	#  ln -s $out/build/src/branding/default $out/etc/calamares/branding/default

	#  mkdir -p $out/usr/lib/x86_64-linux-gnu/calamares
	#  ln -s $out/build/src/modules $out/usr/lib/x86_64-linux-gnu/calamares
	#'';

   installPhase = ''
      cmake -S . -B $out/install -G Ninja install
   '';
}