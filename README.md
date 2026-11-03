# Smart Life — Hassan Yousif Zambrotta Smart Life

**Turn any legacy electrical system into a smart, remotely orchestrated home — without rewiring a single wall.**

Smart Life is a retrofit-first home automation platform: a micro-module that lives inside existing plugs and outlets, a smartphone controller, and orchestration software that gives *old devices* and *old buildings* (yes — even an abandoned cabinet in the woods) full smart-home capability.

> Founded by **Moses** and **Hassan Yousif Zambrotta** — Maritime Telecommunications engineer, telecom veteran.

## Why retrofit-first

- Billions of existing outlets worldwide; nobody wants to rewire.
- The intelligence goes where the electricity already is.
- Any home, cabin, boat, or legacy installation becomes remotely controllable.

## Architecture

```
[Phone / Main Controller App (Flutter)]
              │  Wi-Fi / BLE / MQTT
[ESP32 Micro-Plugin Module]──── inside outlet or plug adapter
   ├── Relay (on/off per outlet)
   ├── Energy metering (BL0937 / HLW8012)
   └── OTA firmware updates
              │
[Orchestration Server (MQTT broker + rules engine)]
```

## Repository layout

| Path | Contents |
|---|---|
| `app/` | Flutter controller app (Hassan's original seed lives in `app/lib/`) |
| `firmware/` | ESP32 micro-plugin firmware |
| `docs/` | Architecture, hardware, and launch roadmap |
| `hardware/` | Schematics & BOM for the outlet module |

## Roadmap

- [x] Original app seed (Hassan): Home/Lights, Plugs, Dimmers screens
- [ ] Move seed into `app/`, add pubspec & Android/iOS scaffolding
- [ ] Device discovery + pairing flow (mDNS / BLE provisioning)
- [ ] MQTT command/control channel
- [ ] ESP32 firmware v0.1 (relay + energy metering + OTA)
- [ ] Offline-first local control, cloud fallback
- [ ] Remote site mode (cabin in the woods: cellular/LTE backhaul)

## License

TBD — will be chosen before public launch.
