# Firefighter Linux v2.0
<p align="center">
  <img src="docs/Firefighter_Linux_V2.png" alt="Firefighter Linux Logo" width="1000"/>
</p>


Afet sahası (saha profili) ve kriz masası (EOC profili) için **offline-first** Linux dağıtımı.  
Anahtar modüller: APRS/AX.25, FFMapper (çevrimdışı harita), Jupyter deprem analizi, Node-RED alarm sistemi, WordPress entegrasyonu.

## Öncelik Sırası
1. APRS/AX.25 (Direwolf + APRX + Xastir) — systemd servisleri, güvenlik, test  
2. FFMapper — MBTiles üretimi, GPKG şeması, ikonlar  
3. Jupyter/Seismo — ObsPy, fay hatları, ETAS; 01..05 defterleri  
4. Node-RED/MQTT — alarm kuralları; Telegram/APRS/E-posta çıkışları  
5. WordPress REST — CPT `field_report` + Python CLI  
6. ISO — Cubic; profil seçici; paket listesi; kabul testleri  

## Varsayılanlar
- APRS path: `WIDE1-1,WIDE2-1`, beacon 180s, igate saha=false, kriz=true  
- Veritabanı: saha=GeoPackage/SQLite, kriz=PostgreSQL+PostGIS  
- MQTT topic prefix: `ffl/`  
- WP-CPT: `field_report`  

## Klasör Yapısı (v2)

- `flows/` — Node-RED akış dosyaları (alarm kuralları, MQTT, Telegram/APRS/E-posta).  
- `scripts/` — Yardımcı betikler (`ffl-aprs-bridge`, `ffl-gpkg-sync`, `ffl-alert`).  
- `notebooks/` — Deprem analiz defterleri: 01_ingest, 02_faults_tr, 03_etas_nowcast, 04_shakemap_light, 05_alert_rules.  
- `ffmapper/` — Çevrimdışı harita aracı (MapLibre, ikonlar, stiller).  
- `docs/` — Proje belgeleri; ana plan burada (`FFL-v2-plan.md`).  
- `installer/` — Cubic/ISO oluşturma notları, profil seçici, paket listeleri.  
- `packages/` — Üçüncü parti `.deb` paketleri ve lisans notları (büyük dosyalar burada tutulmaz).  
- `wp-connector/` — WordPress REST Python CLI.  
- `data_samples/` — Küçük örnek veri setleri (büyük MBTiles/GPKG buraya koyulmaz).  
