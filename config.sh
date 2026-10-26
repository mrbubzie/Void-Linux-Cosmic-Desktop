# ---- Edit me ----
ARCH="aarch64"                       # target arch
LIBC="glibc"                         # glibc | musl  (musl => repo arch aarch64-musl)
VP_DIR="${VP_DIR:-$HOME/void-packages}"
VP_URL="https://github.com/void-linux/void-packages.git"
MAINTAINER="Your Name <you@example.com>"
OUT_DIR="$KIT/out/repo"
JOBS="$(nproc 2>/dev/null || echo 4)"

# Build deps shared by every COSMIC component (trim/extend as builds demand)
COMMON_MAKEDEPS="libxkbcommon-devel wayland-devel wayland-protocols libinput-devel
 libseat-devel eudev-devel pixman-devel mesa-devel libglvnd-devel libgbm-devel
 fontconfig-devel freetype-devel dbus-devel glib-devel libdisplay-info-devel
 pipewire-devel libexpat-devel openssl-devel libxcb-devel libX11-devel"
