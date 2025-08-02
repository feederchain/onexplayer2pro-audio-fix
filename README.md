# ✅ How to Fix Internal Speakers on the OneXPlayer 2 Pro (7840U/8840U)

This guide walks you through enabling internal speaker audio on the **OneXPlayer 2 Pro**. By default, internal speakers may not work out of the box, but a script resolves the issue with a little setup.

>⚠️  Note on `hda-verb` Use
>
>This fix uses `hda-verb` to send low-level audio commands. While widely used, it carries some risk of audio instability or hardware issues.  
>**Use at your own risk.**


---

## 📝 Step-by-Step Instructions

### 1. **Download the Script**

Download `oxp2p-audio-fix.sh`  
All credit for this script goes to fortime2024 from the [One-netbook official Discord](https://discord.com/channels/547366894995243029/1210923924439699516/1399685604932849726) and [here](https://github.com/ChimeraOS/chimeraos/issues/742#issuecomment-2250951477)

---

### 2. **Install ALSA Tools**

```bash
sudo rpm-ostree install alsa-tools
```
A reboot will be recommended after the install is complete.

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
ExecStart=/bin/bash -c '/usr/local/bin/oxp2p-audio-fix.sh -y'
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
The internal speakers should be working at this point.  
After a reboot, they should continue to work. If you reinstall the OS or reset your system, just re-follow this guide.

