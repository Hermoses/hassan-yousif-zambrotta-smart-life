# Smart Life — Technology Overview

**How the technology works, layer by layer, and why each piece was chosen.**
Project: Hassan Yousif Zambrotta Smart Life · Founded by Moses & Hassan Yousif Zambrotta

---

## 1. The core idea

A **micro-module** — small enough to fit inside an existing electrical outlet or plug adapter — adds three capabilities to any outlet:

1. **Switching** — turn the outlet on/off remotely
2. **Metering** — measure voltage, current, and power consumption in real time
3. **Connectivity** — join a wireless network and obey commands from your phone

Nothing in the building's wiring changes. The intelligence is added *at the socket*, which is why any old device — a lamp, a pump, a freezer, a whole legacy cabin — becomes smart.

---

## 2. Layer-by-layer technology

### Layer 1 — The Micro-Module (hardware)

| Component | Technology | Why |
|---|---|---|
| Brain | **ESP32-C3 microcontroller** | ~$1–2, Wi-Fi + Bluetooth built in, industry standard for smart devices, huge ecosystem |
| Switch | **Relay** (mechanical) or Triac | Physically connects/disconnects mains power, isolated from low-voltage logic by an **optocoupler** |
| Metering | **BL0937 / HLW8012 chip** (~$0.30) | Samples voltage/current 2,000+ times per second; reports watts, kWh, and even detects abnormal loads |
| Safety | Thermal fuse, MOV surge suppressor, fire-rated enclosure | Mandatory for mains-voltage products |
| Power supply | AC-DC buck converter | Powers the module from the outlet it sits in |

**Version 1 (prototype): external plug adapter** — safest to build and test.
**Version 2 (product): module inside the outlet plate** — invisible, per-outlet.

### Layer 2 — Wireless communication

- **Wi-Fi (2.4 GHz)** — chosen first because it needs **no extra hub or gateway**: the module talks directly to the home router and to the internet. Every router in the world already supports it.
- **MQTT protocol** — the messaging standard of the Internet of Things. Extremely lightweight (~2 bytes overhead per message), works on weak connections, supports:
  - **Command topics** — `smartlife/site1/room2/outlet3/set` → `{"on": true}`
  - **Status topics** — the module reports back state and power readings
  - **Retained messages** — a module joining the network instantly knows the last commanded state
- **Bluetooth LE (provisioning)** — first-time setup: the phone hands the module the Wi-Fi credentials over BLE, because a fresh module isn't on the network yet.
- **Future option: Thread/Zigbee mesh** — for very dense installations, modules relay messages for each other. Wi-Fi-first keeps v1 simple; the architecture allows adding mesh later.

### Layer 3 — Firmware (software inside the module)

Written in C/C++ on the ESP-IDF framework (with Arduino framework available for rapid prototyping):

- Event-driven loop: no polling delays; reacts to commands in milliseconds
- **Local safety logic even without network**: over-power cutoff, watchdog reset, last-known-state on reboot
- **OTA (Over-The-Air) updates** — firmware can be upgraded remotely after deployment, like phones do
- Typical footprint: < 500 KB — leaves headroom on a $2 chip

### Layer 4 — The Controller App (your smartphone = the main controller)

Built in **Flutter** (Google's cross-platform framework — one codebase for Android, iOS, and desktop; Hassan's original seed screens already run on it):

- **Discovery** — finds modules on the network automatically (mDNS / network scan)
- **Pairing** — BLE handoff of Wi-Fi credentials, like pairing earbuds
- **Control UI** — rooms, outlets, dimmers (Hassan's original screen layout: Home/Lights, Plugs, Dimmers), schedules, scenes
- **Energy dashboard** — per-outlet consumption charts, cost estimates, abnormal-usage alerts (e.g., "freezer drawing 0 W — possible failure")
- **Multi-site** — one account, many properties: house, workshop, cabin

### Layer 5 — Orchestration & remote access

- **Local broker first**: an MQTT broker (open-source Mosquitto or embedded in the app/hub) keeps the house working with zero internet.
- **Cloud relay for remote control**: when you're away, the app and modules connect to a lightweight cloud relay (VPN-style encrypted tunnel). Commands travel: your phone → cloud → home broker → module.
- **Off-grid sites (the cabin scenario)**: any internet source works — an LTE/4G router, Starlink, or even a shared phone hotspot. The module only needs 2.4 GHz Wi-Fi locally; backhaul technology is irrelevant to it. This is why a cabin in the woods with one solar panel and one LTE modem becomes a fully orchestrated site.
- **Rules engine**: "sunset → porch lights on", "if freezer power > X for 10 min → alert", "if total load > Y → shed heavy loads".

### Layer 6 — Security (designed in, not bolted on)

- Every device has unique credentials; TLS encryption for all cloud traffic
- Local network control stays inside the home LAN
- Signed OTA images — a module refuses unsigned firmware
- No cloud dependency for basic on/off control

---

## 3. Why this stack (the honest engineering argument)

| Alternative | Why we didn't lead with it |
|---|---|
| Zigbee/Thread-first (Aqara-style) | Needs a hub/bridge in every home — contradicts our retrofit simplicity |
| Cloud-only (Tuya-style) | Dead devices when internet or vendor cloud dies — against our reliability promise |
| Custom RF proprietary | No ecosystem, no security review, slower development |
| Phone-replaces-everything | The controller orchestrates; the module is what makes an outlet smart. Both are needed |

Our differentiators: **no rewiring · works with old devices · local-first reliability · off-grid friendly · per-outlet energy intelligence**.

## 4. Development path & cost to first demo

| Item | Cost |
|---|---|
| ESP32 dev board | ~$5 |
| Relay module | ~$2 |
| Energy metering breakout | ~$2 |
| Total hardware for prototype #1 | **under $10** |

Timeline to a working demo (app on phone switching a real outlet, showing live wattage): a few weeks of focused development. Custom hardware and safety certification (UL/CE) follow only after the software stack is proven.

---

*Companion documents: [architecture.md](architecture.md) · [roadmap.md](roadmap.md)*
