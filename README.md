# ✅ How to Fix Internal Speakers on the OneXPlayer 2 Pro (7840U/8840U)

This guide walks you through enabling internal speaker audio on the **OneXPlayer 2 Pro**. By default, internal speakers may not work out of the box, but a script resolves the issue with a little setup.

---

## 🧰 Requirements

- OneXPlayer 2 Pro with Bazzite
- `alsa-tools` installed
- Internet access to download the fix script

---

## 📝 Step-by-Step Instructions

### 1. **Download the Script**

Download `oxp2p-audio-fix.sh`

---

### 2. **Install ALSA Tools**

```bash
sudo rpm-ostree install alsa-tools
```

---

### 3. **Move Script to System Path and Set Permissions**

```bash
sudo mv oxp2p-audio-fix.sh /usr/local/bin/
sudo chown root:root /usr/local/bin/oxp2p-audio-fix.sh
sudo chmod +x /usr/local/bin/oxp2p-audio-fix.sh
```

---

### 4. **Create a systemd Service**

```bash
sudo nano /etc/systemd/system/fix_audio.service
```

Paste the following contents:

```ini
[Unit]
Description=Fix audio on the OneXplayer 2 Pro
After=sound.target
Requires=sound.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/oxp2p-audio-fix.sh -y
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
```

---

### 5. **Enable and Start the Service**

```bash
sudo systemctl daemon-reload
sudo systemctl enable fix_audio.service
sudo systemctl start fix_audio.service
```

---

## 🎉 Done!

After a reboot, your internal speakers should work as expected. If you reinstall the OS or reset your system, just re-follow this guide.

