# Firefighter Linux v2.0

Afet sahası (saha profili) ve kriz masası (EOC profili) için **offline-first** Linux dağıtımı.  
Anahtar modüller: APRS/AX.25, FFMapper (çevrimdışı harita), Jupyter deprem analizi, Node-RED alarm sistemi, WordPress entegrasyonu.

## Öncelik Sırası
1. APRS/AX.25 (Direwolf+APRX+Xastir) — systemd servisleri, güvenlik, test
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

## Kullanım
- **Deep research** → dış web/lisans/band plan araştırmaları  
- **/agent** → çok adımlı üretimler (service, akış, kurulum)  
- **Study** → ekibe öğretim/özet


> İlk bootstrap commit
