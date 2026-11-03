<h1 align="center">👥 İKYS</h1>

<p align="center"><strong>İnsan Kaynakları Yönetim Sistemi</strong></p>

<p align="center">Çalışanlar · Maaş ve izinler · Performans · İşe alım</p>

<p align="center">
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/SQL-16324F?style=for-the-badge&logoColor=white" alt="SQL">
  <img src="https://img.shields.io/badge/PL%2FpgSQL-008B8B?style=for-the-badge&logoColor=white" alt="PL/pgSQL">
</p>

---

PostgreSQL üzerinde geliştirilen, insan kaynakları süreçlerini ilişkisel bir veritabanı modeliyle ele alan eğitim projesi. Çalışan ve departman yönetiminden maaş, izin, performans, eğitim ve işe alım süreçlerine kadar temel İK işlemlerini SQL ile modeller.

## ✨ Projede neler var?

| Alan | Kapsam |
| --- | --- |
| 🏢 Organizasyon | Kişi, çalışan, yönetici, departman ve pozisyon kayıtları |
| 💰 Finans | Maaş kayıtları, masraf takibi ve maaş değişiklik geçmişi |
| 🗓️ İzin | Yıllık izin, mazeret izni ve hastalık izni |
| 📈 Gelişim | Performans değerlendirmeleri, kurum içi ve kurum dışı eğitimler |
| 🤝 İşe alım | Aday, işe alım ve mülakat kayıtları |

## 🛠️ SQL çalışmaları

- **İlişkisel model:** Birincil anahtarlar, yabancı anahtarlar ve benzersizlik kısıtları.
- **Raporlama:** JOIN, alt sorgu, GROUP BY, HAVING ve toplulaştırma fonksiyonlarıyla örnek analizler.
- **PL/pgSQL fonksiyonu:** `maas_zammi_yap` ile çalışan maaşına yüzdesel zam uygulanması.
- **Tetikleyici:** `trg_maas_takip` ile maaş değişikliklerinin `maas_degisim_tablosu` tablosuna kaydedilmesi.
- **Görünüm:** `calisan_detay` ile çalışan, departman, pozisyon, maaş, masraf ve izin bilgilerinin bir araya getirilmesi.
- **İlişkisel silme:** `ON DELETE CASCADE` kullanımını gösteren bir izin örneği.

## 🚀 Çalıştırma

PostgreSQL ve isteğe bağlı olarak pgAdmin gerekir. Proje dosyası UTF-8 kodlamasındadır.

1. Proje için boş bir veritabanı oluşturun:

   ```sh
   createdb -U postgres -E UTF8 ikys_demo
   ```

2. SQL dosyasını proje klasöründen çalıştırın:

   ```sh
   psql -U postgres -d ikys_demo -v ON_ERROR_STOP=1 -f sql/ikys.sql
   ```

   pgAdmin kullanıyorsanız boş veritabanının **Query Tool** penceresinde `sql/ikys.sql` dosyasını açıp çalıştırabilirsiniz. Kullanıcı adını kendi PostgreSQL kurulumunuza göre değiştirin.

3. Çalışan görünümünü inceleyin:

   ```sql
   SELECT * FROM calisan_detay;
   ```

## 📁 Dosya yapısı

```text
ikys-postgresql/
├── README.md
├── .gitignore
└── sql/
    └── ikys.sql
```

## 📝 Kullanım

SQL dosyası tablo oluşturma komutlarını, örnek kayıtları ve ders kapsamında hazırlanmış uygulama sorgularını birlikte içerir. Maaş güncelleme ve CASCADE örnekleri veriyi değiştirir; dosyayı ayrı, boş bir deneme veritabanında çalıştırın. Aynı veritabanında tekrar çalıştırmak mevcut tablolar nedeniyle hata verebilir.

