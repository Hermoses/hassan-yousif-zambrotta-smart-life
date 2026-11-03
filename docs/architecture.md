# Smart Life — System Architecture

## Design principles
1. **Retrofit first** — never require rewiring; the module adapts to the existing system.
2. **Maximum capability from old devices** — legacy appliances become smart endpoints via switched/metered outlets.
3. **Local-first** — the house must work without internet; cloud is an enhancement, not a dependency.
4. **Remote orchestration** — one phone (or any capable device) is the main controller for one or many sites.

## Layers

### 1. Endpoint layer — Micro-Plugin Module
- Fits inside an existing outlet (v2) or as a plug adapter (v1, safest for prototyping).
- MCU: ESP32-C3 (Wi-Fi + BLE, ~$1–2).
- Relay rated for mains; optocoupler isolation.
- Energy metering: BL0937/HLW8012 (voltage/current/power per outlet).
- Firmware: event-driven, MQTT client, OTA updates, BLE provisioning.

### 2. Radio layer
- **v1:** Wi-Fi (2.4 GHz) + MQTT — fastest path, no hub hardware.
- **v2 option:** Thread/Zigbee mesh for low power & dense installations.

### 3. Control layer — Main Controller App (Flutter)
- Device discovery, pairing, rooms/zones.
- On/off, dimming, schedules, energy dashboards.
- Multiple "sites" (homes, cabins) under one account.

### 4. Orchestration layer
- MQTT broker (local on a hub/phone hotspot, cloud for remote access).
- Rules engine: scenes, automations ("sunset → porch lights"), energy alerts.
- Remote site backhaul: LTE router / satellite for off-grid cabins.

## Safety & certification (required before hardware launch)
- Mains isolation, thermal fusing, fire-rated enclosure.
- UL (US) / CE (EU) certification pathway for the outlet module.
- v1 ships as external plug adapter to de-risk certification while firmware/app mature.
