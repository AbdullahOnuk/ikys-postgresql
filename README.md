# İKYS | İnsan Kaynakları Yönetim Sistemi

PostgreSQL üzerinde geliştirilen, insan kaynakları süreçlerini ilişkisel bir veritabanı modeliyle ele alan eğitim projesi. Çalışan ve departman yönetiminden maaş, izin, performans, eğitim ve işe alım süreçlerine kadar temel İK işlemlerini SQL ile modeller.

## Projede neler var?

| Alan | Kapsam |
| --- | --- |
| Organizasyon | Kişi, çalışan, yönetici, departman ve pozisyon kayıtları |
| Finans | Maaş kayıtları, masraf takibi ve maaş değişiklik geçmişi |
| İzin | Yıllık izin, mazeret izni ve hastalık izni |
| Gelişim | Performans değerlendirmeleri, kurum içi ve kurum dışı eğitimler |
| İşe alım | Aday, işe alım ve mülakat kayıtları |

## Öne çıkan SQL çalışmaları

- **İlişkisel model:** Birincil anahtarlar, yabancı anahtarlar ve benzersizlik kısıtları.
- **Raporlama:** JOIN, alt sorgu, GROUP BY, HAVING ve toplulaştırma fonksiyonlarıyla örnek analizler.
- **PL/pgSQL fonksiyonu:** `maas_zammi_yap` ile çalışan maaşına yüzdesel zam uygulanması.
- **Tetikleyici:** `trg_maas_takip` ile maaş değişikliklerinin `maas_degisim_tablosu` tablosuna kaydedilmesi.
- **Görünüm:** `calisan_detay` ile çalışan, departman, pozisyon, maaş, masraf ve izin bilgilerinin bir araya getirilmesi.
- **İlişkisel silme:** `ON DELETE CASCADE` kullanımını gösteren bir izin örneği.

## Çalıştırma

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

## Dosya yapısı

```text
ikys-postgresql/
├── README.md
├── .gitignore
└── sql/
    └── ikys.sql
```

## Kullanım notları

SQL dosyası tablo oluşturma komutlarını, örnek kayıtları ve ders kapsamında hazırlanmış uygulama sorgularını birlikte içerir. Maaş güncelleme ve CASCADE örnekleri veriyi değiştirir; dosyayı ayrı, boş bir deneme veritabanında çalıştırın. Aynı veritabanında tekrar çalıştırmak mevcut tablolar nedeniyle hata verebilir.

Bu depo masaüstü veya web arayüzü içermez; projenin odağı veritabanı tasarımı ve SQL uygulamalarıdır. Yerel PostgreSQL sunucusundaki güncel veritabanının dışa aktarımı değildir. Mevcut SQL kaynak dosyası temel alınmıştır; canlı PostgreSQL bağlantısıyla çalıştırma doğrulaması henüz yapılmamıştır.
