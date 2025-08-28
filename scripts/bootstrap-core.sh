#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "Lütfen sudo ile çalıştırın: sudo bash scripts/bootstrap-core.sh"; exit 1
fi

TARGET_USER="${SUDO_USER:-$(logname)}"
FF_BASE="/opt/firefighter"
FF_BIN="$FF_BASE/bin"
FF_ETC="/etc/firefighter"
FF_DATA="/data"
FF_TILES="$FF_DATA/gis/tiles"
FF_FIELD="$FF_DATA/field"
FF_NOTEBOOKS="/home/${TARGET_USER}/Notebooks/FFL"

echo "[FFL] Dizinler oluşturuluyor..."
install -d -m 0755 "$FF_BASE" "$FF_BIN" "$FF_ETC" \
  "$FF_DATA" "$FF_DATA/gis" "$FF_TILES" "$FF_DATA/gis/sources" \
  "$FF_DATA/db" "$FF_FIELD" "$FF_NOTEBOOKS"
chown -R "${TARGET_USER}:${TARGET_USER}" "$FF_DATA" "$FF_NOTEBOOKS" || true

echo '[FFL] PATH entegrasyonu...'
cat >/etc/profile.d/firefighter.sh <<'EOP'
# Firefighter Linux
export PATH="/opt/firefighter/bin:$PATH"
export FFL_HOME="/opt/firefighter"
export FFL_DATA="/data"
export FFL_TILES="/data/gis/tiles"
export FFL_FIELD="/data/field"
EOP
chmod 0644 /etc/profile.d/firefighter.sh

echo "[FFL] Temel paketler yükleniyor..."
apt-get update -y
apt-get install -y \
  ufw fail2ban firejail apparmor apparmor-profiles apparmor-utils \
  git curl wget rsync jq sqlite3 htop tmux \
  geany terminator flameshot xdg-utils \
  python3 python3-venv python3-pip

if dpkg -s openssh-server >/dev/null 2>&1; then
  ufw allow OpenSSH || true
fi

echo "[FFL] UFW ve Fail2ban ayarlanıyor..."
ufw default deny incoming
ufw default allow outgoing
ufw --force enable

cat >/etc/fail2ban/jail.d/sshd.local <<'EOP'
[sshd]
enabled = true
bantime = 1h
findtime = 10m
maxretry = 6
EOP
systemctl restart fail2ban

echo "[FFL] ffctl yükleniyor..."
install -m 0755 -o root -g root -T "$(pwd)/scripts/ffctl" "$FF_BIN/ffctl"

echo "[FFL] Kullanıcı yetkileri (seri/SDR için)..."
usermod -aG dialout,plugdev,video,audio,tty "${TARGET_USER}" || true

echo "[FFL] Tamam. Yeni PATH için yeni terminal açın veya 'source /etc/profile.d/firefighter.sh' çalıştırın."
echo "Kontrol: ffctl info"
