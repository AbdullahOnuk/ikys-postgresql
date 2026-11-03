-- 1) KİŞİ
-- ---------------------------
CREATE TABLE kisi (
    kisi_id SERIAL PRIMARY KEY,
    tckno CHAR(11) UNIQUE,
    ad_soyad VARCHAR(150) NOT NULL,
    e_mail VARCHAR(100) UNIQUE NOT NULL,
    telno VARCHAR(20),
    adres TEXT
);

INSERT INTO kisi (tckno, ad_soyad, e_mail, telno, adres) VALUES
('11111111111','Ahmet Yılmaz','ahmet@firma.com','05330000001','İstanbul'),
('22222222222','Ayşe Demir','ayse@firma.com','05330000002','Ankara'),
('33333333333','Mehmet Polat','mehmet@firma.com','05330000003','İzmir'),
('44444444444','Esra Kaplan','esra@firma.com','05330000004','Bursa'),
('55555555555','Canan Sever','canan@firma.com','05330000005','Adana'),
('66666666666','Kerem Taş','kerem@firma.com','05330000006','İstanbul'),
('77777777777','Derya Oruç','derya@firma.com','05330000007','Ankara'),
('88888888888','Süleyman Koca','suleyman@firma.com','05330000008','Kocaeli'),
('99999999999','Merve Boz','merve@firma.com','05330000009','İzmir'),
('12345678901','Serhat Gün','serhat@firma.com','05330000010','Antalya');

SELECT * FROM kisi;
-- ---------------------------
-- 2) DEPARTMAN
-- ---------------------------
CREATE TABLE departman (
    departman_id SERIAL PRIMARY KEY,
    departman_adi VARCHAR(100) NOT NULL UNIQUE,
    departman_yonetici_id INT
);

-- NULL kullanmamızın sebebi ise çalışanı henüz sisteme girmeden onu yönetici ilan edemeyeceğimiz için
INSERT INTO departman (departman_adi, departman_yonetici_id) VALUES
('İnsan Kaynakları',NULL),
('Yazılım',NULL),
('Muhasebe',NULL),
('Siber Güvenlik',NULL),
('Test ve Kalite',NULL),
('Müşteri Hizmetleri',NULL),
('Marketing',NULL), 
('Satış',NULL),
('IT Destek',NULL),
('Lojistik',NULL);

SELECT * FROM departman;
-- ---------------------------
-- 3) POZİSYON
-- ---------------------------
CREATE TABLE pozisyon (
    pozisyon_id SERIAL PRIMARY KEY,
    pozisyon_adi VARCHAR(100) NOT NULL,
    kidem_seviyesi VARCHAR(50),
    departman_id INT,
    pozisyon_tipi VARCHAR(20) NOT NULL, 
    haftalik_calisma_saati INT,
    izin_hakki INT,
    ogrenim_durumu VARCHAR(100),
    FOREIGN KEY (departman_id) REFERENCES departman(departman_id)
);

INSERT INTO pozisyon (
    pozisyon_adi, kidem_seviyesi, departman_id,
    pozisyon_tipi, haftalik_calisma_saati,
    izin_hakki, ogrenim_durumu
) VALUES
('IK Uzmanı','Orta',1,'Tam Zamanlı',40,20,'Üniversite'),
('Yazılım Geliştirici','Orta',2,'Tam Zamanlı',40,20,'Üniversite'),
('Kıdemli Yazılımcı','Kıdemli',2,'Tam Zamanlı',40,22,'Üniversite'),
('Muhasebe Elemanı','Junior',3,'Tam Zamanlı',40,18,'Lise'),
('Siber Güvenlik Analisti','Orta',4,'Tam Zamanlı',40,20,'Üniversite'),
('Test Mühendisi','Junior',5,'Yarı Zamanlı',30,18,'Üniversite'),
('Müşteri Temsilcisi','Junior',6,'Tam Zamanlı',40,18,'Lise'),
('Satış Uzmanı','Orta',8,'Yarı Zamanlı',30,20,'Üniversite'),
('IT Destek Elemanı','Junior',9,'Tam Zamanlı',40,18,'Üniversite'),
('Stajyer Yazılımcı','Stajyer',2,'Staj',30,0,'Üniversite');

SELECT * FROM pozisyon;

-- ---------------------------
-- 4) ÇALIŞAN
-- ---------------------------
CREATE TABLE calisan (
    calisan_id SERIAL PRIMARY KEY,
    kisi_id INT UNIQUE NOT NULL,
    ise_giris_tarihi DATE NOT NULL,
    pozisyon_id INT NOT NULL,
    yonetici_id INT, 
    FOREIGN KEY (kisi_id) REFERENCES kisi(kisi_id),
    FOREIGN KEY (pozisyon_id) REFERENCES pozisyon(pozisyon_id),
    FOREIGN KEY (yonetici_id) REFERENCES calisan(calisan_id) 
);

INSERT INTO calisan (kisi_id, ise_giris_tarihi, pozisyon_id, yonetici_id) VALUES
(1,'2024-01-10',1,NULL),
(2,'2020-02-11',2,1),
(3,'2019-03-12',3,1),
(4,'2023-04-13',4,1),
(5,'2017-05-14',5,2),
(6,'2012-06-15',6,2),
(7,'2009-07-16',7,2),
(8,'2025-08-17',8,3),
(9,'2019-09-18',9,3),
(10,'2021-10-19',10,3);

SELECT * FROM calisan;
-- ---------------------------
-- 5) YÖNETİCİ
-- ---------------------------
CREATE TABLE yonetici (
    yonetici_id INT PRIMARY KEY,
    yonetici_adi VARCHAR(30) NOT NULL,
    yonetici_departman_id INT,
    FOREIGN KEY (yonetici_departman_id) REFERENCES departman(departman_id),
    FOREIGN KEY (yonetici_id) REFERENCES calisan(calisan_id)
);

INSERT INTO yonetici (yonetici_id, yonetici_adi, yonetici_departman_id) VALUES
(1, 'Ahmet Yılmaz', 1),
(2, 'Ayşe Demir', 2),
(3, 'Mehmet Polat', 3),
(4, 'Esra Kaplan', 4),
(5, 'Canan Sever', 5),
(6, 'Kerem Taş', 6),
(7, 'Derya Oruç', 7),
(8, 'Süleyman Koca', 8),
(9, 'Merve Boz', 9),
(10, 'Serhat Gün', 10);

SELECT * FROM yonetici;

-- ---------------------------
-- 6) MAAŞ
-- ---------------------------
CREATE TABLE maas (
    maas_id SERIAL PRIMARY KEY,
    calisan_id INT UNIQUE NOT NULL,
    tutar NUMERIC(10,2) NOT NULL,
    tarih DATE NOT NULL,
    tur VARCHAR(50),
    FOREIGN KEY (calisan_id) REFERENCES calisan(calisan_id)
);

INSERT INTO maas (calisan_id, tutar, tarih, tur) VALUES
(1,35000,'2025-01-01','Aylık'),
(2,40000,'2025-01-01','Aylık'),
(3,45000,'2025-01-01','Aylık'),
(4,30000,'2025-01-01','Aylık'),
(5,37000,'2025-01-01','Aylık'),
(6,33000,'2025-01-01','Aylık'),
(7,27000,'2025-01-01','Aylık'),
(8,39000,'2025-01-01','Aylık'),
(9,32500,'2025-01-01','Aylık'),
(10,15000,'2025-01-01','Staj');

SELECT * FROM maas;
-- ---------------------------
-- 7) MASRAF
-- ---------------------------
CREATE TABLE masraf (
    masraf_id SERIAL PRIMARY KEY,
    calisan_id INT NOT NULL,
    masraf_tutari NUMERIC(10,2) NOT NULL,
    onay_yonetici_id INT,
    aciklama TEXT,
    tarih DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (calisan_id) REFERENCES calisan(calisan_id),
    FOREIGN KEY (onay_yonetici_id) REFERENCES yonetici(yonetici_id)
);

INSERT INTO masraf (calisan_id, masraf_tutari, onay_yonetici_id, aciklama, tarih) VALUES
(1,250,2,'Yol masrafı','2025-01-05'),
(2,100,1,'Kırtasiye','2025-01-06'),
(3,320,6,'Ekipman','2025-01-07'),
(4,90,9,'Yemek','2025-01-08'),
(5,150,4,'Eğitim masrafı','2025-01-09'),
(6,180,8,'Ulaşım','2025-01-10'),
(7,210,2,'Malzeme','2025-01-11'),
(8,500,7,'Donanım','2025-01-12'),
(9,75,3,'Yemek','2025-01-13'),
(10,60,5,'Ulaşım','2025-01-14');

SELECT * FROM masraf;
-- ---------------------------
-- 8) PERFORMANS
-- ---------------------------
CREATE TABLE performans (
    performans_id SERIAL PRIMARY KEY,
    calisan_id INT NOT NULL,
    departman_yonetici_id INT NOT NULL,
    degerlendirme_tarihi DATE NOT NULL,
    skor INT NOT NULL,
    notlar TEXT,
    FOREIGN KEY (calisan_id) REFERENCES calisan(calisan_id),
    FOREIGN KEY (departman_yonetici_id) REFERENCES yonetici(yonetici_id)
);

INSERT INTO performans (calisan_id, departman_yonetici_id, degerlendirme_tarihi, skor, notlar) VALUES
(1, 1, '2025-01-10', 85, 'Hedeflerinin çoğunu başarıyla tamamladı.'),
(2, 4, '2025-01-12', 90, 'İletişim ve ekip çalışmasında güçlü.'),
(3, 5, '2025-02-01', 70, 'Zaman yönetiminde iyileşme gerekli.'),
(4, 8, '2025-02-15', 88, 'Teknik konularda uzmanlık artıyor.'),
(5, 2, '2025-02-20', 92, 'Örnek gösterilecek performans.'),
(6, 3, '2025-03-05', 65, 'Görev teslimlerinde gecikmeler yaşandı.'),
(7, 3, '2025-03-18', 78, 'Ortalama üzerinde ancak geliştirilebilir.'),
(8, 2, '2025-04-01', 96, 'Yüksek başarı, müşteri memnuniyeti olumlu.'),
(9, 9, '2025-04-10', 81, 'Sürekli gelişim gösteriyor.'),
(10,7, '2025-04-20', 89, 'İş çıktılarında istikrar var.');

SELECT * FROM performans;
-- ---------------------------
-- IZIN TUR 
CREATE TABLE izin_tur (
    izin_tur_id SERIAL PRIMARY KEY,
    izin_tur_adi VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO izin_tur (izin_tur_adi) VALUES
('Yıllık'),   
('Mazeret'), 
('Hastalık'); 

SELECT * FROM izin_tur;

-- 9) IZIN
-----------------------------
CREATE TABLE izin (
    izin_id INT PRIMARY KEY,
    calisan_id INT NOT NULL,
    izin_tur_id INT NOT NULL,   -- 1: Yıllık, 2: Mazeret, 3: Hastalık
    baslangic_tarihi DATE NOT NULL,
    bitis_tarihi DATE NOT NULL,
    onay_durumu VARCHAR(20) NOT NULL,
    onay_yonetici_id INT,
    talep_tarihi DATE,
    FOREIGN KEY (calisan_id) REFERENCES calisan(calisan_id),
	FOREIGN KEY (izin_tur_id) REFERENCES izin_tur(izin_tur_id),
    FOREIGN KEY (onay_yonetici_id) REFERENCES yonetici(yonetici_id)
);


INSERT INTO izin (izin_id, calisan_id, izin_tur_id, baslangic_tarihi, bitis_tarihi, onay_durumu, onay_yonetici_id) VALUES
(100, 1, 1, '2025-06-01','2025-06-05','Onaylandı',1),
(101, 2, 3, '2025-07-10','2025-07-12','Onaylandı',2),
(102, 3, 2, '2025-08-14','2025-08-15','Onaylandı',3),
(103, 4, 1, '2025-09-01','2025-09-07','Onaylandı',4),
(104, 5, 2, '2025-03-21','2025-03-23','Onaylandı',5),
(105, 6, 3, '2025-04-02','2025-04-03','Onaylandı',6),
(106, 7, 1, '2025-10-11','2025-10-14','Onaylandı',7),
(107, 8, 3, '2025-05-16','2025-05-17','Onaylandı',8),
(108, 9, 2, '2025-11-09','2025-11-10','Onaylandı',9),
(109, 10, 1, '2025-02-01','2025-02-06','Onaylandı',10);

SELECT * FROM izin;

-- ---------------------------
-- 10) IZIN alt-sınıfları
-- ---------------------------

CREATE TABLE izin_yillik ( -- id =1
    izin_id INT PRIMARY KEY,
    yil INT NOT NULL, 
    kullanilan_gun INT DEFAULT 0,
    kalan_gun INT,
    FOREIGN KEY (izin_id) REFERENCES izin(izin_id)
);

INSERT INTO izin_yillik VALUES
(100,2025,5,15),
(103,2025,7,13),
(106,2025,4,16),
(109,2025,6,14);

SELECT * FROM izin_yillik;


CREATE TABLE izin_mazaret ( -- id=2
    izin_id INT PRIMARY KEY,
    mazeret_tipi VARCHAR(100),  
    aciklama TEXT,
    FOREIGN KEY (izin_id) REFERENCES izin(izin_id)
);

INSERT INTO izin_mazaret VALUES
(102,'Ailevi','Ailevi nedenler'),
(104,'Taşınma','Ev taşıma'),
(108,'Özel','Bankacılık işlemleri');

SELECT * FROM izin_mazaret;

DROP TABLE IF EXISTS izin_hastalik;-- id=3
CREATE TABLE izin_hastalik ( 
    izin_id INT PRIMARY KEY,
    tani VARCHAR(150),
    rapor_basi_tarihi DATE,
    rapor_bitis_tarihi DATE,
    FOREIGN KEY (izin_id) REFERENCES izin(izin_id) ON DELETE CASCADE
);

INSERT INTO izin_hastalik VALUES
(101,'Grip','2025-07-10','2025-07-12'),
(105,'Baş ağrısı','2025-04-02','2025-04-03'),
(107,'Alerji','2025-05-16','2025-05-17');

SELECT * FROM izin_hastalik;
-- ---------------------------
-- 11) EGITIM
-- ---------------------------
CREATE TABLE egitim (
    egitim_id INT PRIMARY KEY,
    egitimadi VARCHAR(200) NOT NULL,
    egitim_suresi INT, 
    egitmen_bilgisi VARCHAR(200),
    tarih DATE
);

INSERT INTO egitim (egitim_id,egitimadi, egitim_suresi, egitmen_bilgisi, tarih) VALUES
(1,'Liderlik Eğitimi',16,'Murat Aksoy','2025-01-10'),
(2,'İletişim ve İkna',8,'Zeynep Öztürk','2025-02-05'),
(3,'Zaman Yönetimi',6,'Ali Kaya','2025-03-12'),
(4,'Python ile Veri Analizi',24,'Dr. Ferhat Demir','2025-01-25'),
(5,'Siber Güvenlik 101',20,'Uzman M. Kara','2025-01-15'),
(6,'Müşteri Deneyimi Geliştirme',12,'Seda Yalçın','2025-02-18'),
(7,'Proje Yönetimi - PMP',32,'Günay Sönmez','2025-04-01'),
(8,'Excel İleri Düzey',10,'Burcu Çetin','2025-02-02'),
(9,'Satış ve Pazarlama',14,'Hakan Tek','2025-03-22'),
(10,'Kurumsal İmaj ve Temsil',6,'Bora Yıldız','2025-01-19');

SELECT * FROM egitim;

-- ---------------------------
-- 12) EGITIM alt-sınıfları
-- ---------------------------
CREATE TABLE egitim_ic (
    egitim_id INT PRIMARY KEY,
    kurum_ici_birim VARCHAR(200),
    FOREIGN KEY (egitim_id) REFERENCES egitim(egitim_id)
);

INSERT INTO egitim_ic (egitim_id, kurum_ici_birim) VALUES
(1,'İnsan Kaynakları Departmanı'),
(2,'Kurumsal İletişim Departmanı'),
(3,'Strateji ve Planlama Departmanı'),
(4,'Bilgi İşlem / Veri Analizi Ekibi'),
(5,'Siber Güvenlik Departmanı');

SELECT * FROM egitim_ic;


CREATE TABLE egitim_dis (
    egitim_id INT PRIMARY KEY,
    dis_kurum_adi VARCHAR(200),
    FOREIGN KEY (egitim_id) REFERENCES egitim(egitim_id)
);


INSERT INTO egitim_dis (egitim_id, dis_kurum_adi) VALUES
(6,'CX Academy'),
(7,'PMI Institute'),
(8,'Global Excel Academy'),
(9,'SalesMasters International'),
(10,'Corporate Image Institute');

SELECT * FROM egitim_dis;

-- ---------------------------
-- 13) ADAY
-- ---------------------------
CREATE TABLE aday (
    kisi_id INT PRIMARY KEY,
    basvuru_tarihi DATE NOT NULL,
    adayin_durumu VARCHAR(50) NOT NULL,
    FOREIGN KEY (kisi_id) REFERENCES kisi(kisi_id)
);

INSERT INTO aday (kisi_id, basvuru_tarihi, adayin_durumu) VALUES
(1,'2025-01-01','Başvurdu'),
(2,'2025-01-02','Mülakat'),
(3,'2025-01-03','Reddedildi'),
(4,'2025-01-04','Kabul'),
(5,'2025-01-05','Teklif'),
(6,'2025-01-06','Mülakat'),
(7,'2025-01-07','Başvurdu'),
(8,'2025-01-08','Reddedildi'),
(9,'2025-01-09','Teklif'),
(10,'2025-01-10','Değerlendirme');

SELECT * FROM aday;

-- ---------------------------
-- 14) IS_ALIM
-- ---------------------------
CREATE TABLE is_alim (
    is_alim_id SERIAL PRIMARY KEY,
    aday_id INT NOT NULL,
    tarih DATE NOT NULL,
    teklif_tutari INT,
    FOREIGN KEY (aday_id) REFERENCES kisi(kisi_id)
);

INSERT INTO is_alim (aday_id, tarih, teklif_tutari) VALUES
(5,'2025-01-05',30000),
(6,'2025-01-06',30000),
(7,'2025-01-07',NULL),
(4,'2025-01-10',35000),
(5,'2025-01-11',33000),
(6,'2025-01-12',31000),
(7,'2025-01-13',NULL),
(8,'2025-01-14',NULL),
(9,'2025-01-15',35500),
(10,'2025-01-16',36000);

SELECT * FROM is_alim;

-- ---------------------------
-- 15) MULAKAT
-- ---------------------------
CREATE TABLE mulakat (
    mulakat_id SERIAL PRIMARY KEY,
    ise_alim_id INT NOT NULL,
    aday_id INT NOT NULL,
    tarih DATE NOT NULL,
    degerlendirme_notu TEXT,
    sonuc VARCHAR(50) NOT NULL,
    FOREIGN KEY (ise_alim_id) REFERENCES is_alim(is_alim_id),
    FOREIGN KEY (aday_id) REFERENCES aday(kisi_id)
);

INSERT INTO mulakat (ise_alim_id, aday_id, tarih, degerlendirme_notu, sonuc) VALUES
(1,1,'2025-01-05','Olumlu','Geçti'),
(2,2,'2025-01-06','Teknik yeterli','Geçti'),
(3,3,'2025-01-07','Yetersiz','Kaldı'),
(4,4,'2025-01-10','Güzel iletişim','Geçti'),
(5,5,'2025-01-11','Orta','Teklif'),
(6,6,'2025-01-12','Başarılı','Geçti'),
(7,7,'2025-01-13','Eksikler var','Değerlendiriliyor'),
(8,8,'2025-01-14','İletişim zayıf','Kaldı'),
(9,9,'2025-01-15','İyi','Teklif'),
(10,10,'2025-01-16','Tatmin edici','Değerlendirme');

SELECT * FROM mulakat;

------------------------------------
--SORGULAR
-----------------------------------------

---SÜRESİ 10 SAATTEN FAZLAN OLAN DIŞ EĞİTİMLER----

SELECT 
    e.egitimadi,
    e.egitmen_bilgisi,
    ed.dis_kurum_adi,
    e.egitim_suresi
FROM egitim e
JOIN egitim_dis ed ON e.egitim_id = ed.egitim_id
WHERE e.egitim_suresi >= 10 
ORDER BY e.egitim_suresi DESC; 

----- Ortalama
SELECT
    yonetici.yonetici_adi,
    AVG(masraf.masraf_tutari) AS ortalama_onay_masrafi
FROM yonetici
LEFT JOIN
    masraf ON yonetici.yonetici_id = masraf.onay_yonetici_id
GROUP BY
    yonetici.yonetici_adi
HAVING
    AVG(masraf.masraf_tutari) > 200
LIMIT 2;

--pozisyon adı içerisinde 'Staj' veya 'Yarı' kelimeleri geçen tüm pozisyonları bulur

SELECT DISTINCT
    departman.departman_adi
FROM
    pozisyon
INNER JOIN
    departman ON pozisyon.departman_id = departman.departman_id
WHERE
    pozisyon.pozisyon_tipi ILIKE '%staj%' 
    OR pozisyon.pozisyon_tipi ILIKE '%yarı%';

------HASTALIKTAN İZİN ALANLAR
SELECT 
    k.ad_soyad,
    i.baslangic_tarihi,
    i.bitis_tarihi,
    ih.tani,              
    ih.rapor_basi_tarihi
FROM izin i
JOIN izin_hastalik ih ON i.izin_id = ih.izin_id 
JOIN calisan c ON i.calisan_id = c.calisan_id
JOIN kisi k ON c.kisi_id = k.kisi_id;

--- MÜLAKATI GEÇENLER
SELECT 
    k.ad_soyad,
    k.e_mail,
    a.basvuru_tarihi,
    mul.degerlendirme_notu,
    ia.teklif_tutari
FROM aday a
JOIN kisi k ON a.kisi_id = k.kisi_id
JOIN is_alim ia ON a.kisi_id = ia.aday_id
JOIN mulakat mul ON ia.is_alim_id = mul.ise_alim_id
WHERE mul.sonuc = 'Geçti' AND ia.teklif_tutari IS NOT NULL;

--- DEPARTMANLARIN maaş ortalaması
SELECT 
    d.departman_adi,
    COUNT(c.calisan_id) as calisan_sayisi,
    ROUND(AVG(m.tutar), 2) as ortalama_maas,
    MIN(m.tutar) as en_dusuk_maas,
    MAX(m.tutar) as en_yuksek_maas
FROM departman d
JOIN pozisyon p ON d.departman_id = p.departman_id
JOIN calisan c ON p.pozisyon_id = c.pozisyon_id
JOIN maas m ON c.calisan_id = m.calisan_id
GROUP BY d.departman_adi
ORDER BY ortalama_maas DESC;

---- PERFORMANS SKORU 85 ÜZERİ OLANLARLA TOPLU %10 ZAM

UPDATE maas
SET tutar = tutar * 1.10
WHERE calisan_id IN (
    SELECT calisan_id 
    FROM performans 
    WHERE skor >= 85);

SELECT * FROM maas WHERE calisan_id IN (SELECT calisan_id FROM performans WHERE skor >= 85);

---- ÇALIŞANLARI LİSE ÜNİVERSİTE TAM ZAMANLI YARI ZAMANLI DİYE GRUPLANDIRAN SORGU

SELECT 
    ogrenim_durumu,
    pozisyon_tipi,
    COUNT(*) as toplam_sayi,
    STRING_AGG(pozisyon_adi, ', ') as pozisyonlar
FROM pozisyon
WHERE ogrenim_durumu IN ('Üniversite', 'Lise')
  AND pozisyon_tipi IN ('Tam Zamanlı', 'Yarı Zamanlı')
GROUP BY ogrenim_durumu, pozisyon_tipi
ORDER BY ogrenim_durumu DESC;



----------------------------------------------------------------------
--CASCADE ÖRNEGİ

DROP TABLE IF EXISTS izin_hastalik;
CREATE TABLE izin_hastalik ( 
    izin_id INT PRIMARY KEY,
    tani VARCHAR(150),
    rapor_basi_tarihi DATE,
    rapor_bitis_tarihi DATE,
    FOREIGN KEY (izin_id) REFERENCES izin(izin_id) ON DELETE CASCADE
);

INSERT INTO izin_hastalik VALUES
(101,'Grip','2025-07-10','2025-07-12'),
(105,'Baş ağrısı','2025-04-02','2025-04-03'),
(107,'Alerji','2025-05-16','2025-05-17');

SELECT * FROM izin order by izin_id;
SELECT * FROM izin_hastalik order by izin_id;

SELECT * FROM izin WHERE izin_id = 101;
SELECT * FROM izin_hastalik WHERE izin_id = 101;


DELETE FROM izin WHERE izin_id = 101;

INSERT INTO izin (izin_id, calisan_id, izin_tur_id, baslangic_tarihi, bitis_tarihi, onay_durumu, onay_yonetici_id) 
VALUES (101, 1, 1, '2025-06-01','2025-06-05','Onaylandı',1);

INSERT INTO izin_hastalik (izin_id, tani, rapor_basi_tarihi, rapor_bitis_tarihi)
VALUES (101,'Grip','2025-07-10','2025-07-12');

-----------------------------------------------------------------
-- FONKSİYON 
CREATE OR REPLACE FUNCTION maas_zammi_yap(
    p_calisan_id INT,   
    p_zam_orani NUMERIC
)
RETURNS TEXT AS $$ 
DECLARE
    v_eski_maas NUMERIC;
    v_yeni_maas NUMERIC;
    v_ad_soyad VARCHAR;
BEGIN
    SELECT k.ad_soyad, m.tutar 
    INTO v_ad_soyad, v_eski_maas
    FROM maas m
    JOIN calisan c ON m.calisan_id = c.calisan_id
    JOIN kisi k ON c.kisi_id = k.kisi_id
    WHERE m.calisan_id = p_calisan_id;
	
    IF v_eski_maas IS NULL THEN
        RETURN 'HATA: Bu ID ile kayıtlı bir çalışan veya maaş bilgisi bulunamadı!';
    END IF;

    v_yeni_maas := v_eski_maas + (v_eski_maas * p_zam_orani / 100);

    UPDATE maas 
    SET tutar = v_yeni_maas 
    WHERE calisan_id = p_calisan_id;
    RETURN v_ad_soyad || ' isimli çalışanın maaşı %' || p_zam_orani || 
           ' zam ile ' || v_eski_maas || ' TL''den ' || v_yeni_maas || ' TL''ye yükseltildi.';
END;
$$ LANGUAGE plpgsql;


SELECT maas_zammi_yap(1, 20);
SELECT maas_zammi_yap(2,10);
SELECT * FROM kisi;
SELECT maas_zammi_yap(0,10);

SELECT * FROM maas WHERE calisan_id = 1;
SELECT * FROM maas WHERE calisan_id = 2;

--------------------------------------------------------------
-- TRIGGER
CREATE TABLE maas_degisim_tablosu (
    log_id SERIAL PRIMARY KEY,
    calisan_id INT,
    eski_maas NUMERIC,
    yeni_maas NUMERIC,
    degisim_tarihi DATE 
);

CREATE OR REPLACE FUNCTION maas_tablosu_tetikleyicisi()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tutar <> OLD.tutar THEN
        INSERT INTO maas_degisim_tablosu (calisan_id, eski_maas, yeni_maas, degisim_tarihi)
        VALUES (OLD.calisan_id, OLD.tutar, NEW.tutar, CURRENT_DATE); 
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_maas_takip	
AFTER UPDATE ON maas
FOR EACH ROW
EXECUTE FUNCTION maas_tablosu_tetikleyicisi();


SELECT * FROM maas WHERE calisan_id=4;
SELECT maas_zammi_yap(4, 10);
SELECT * FROM maas_degisim_tablosu;

-------------------------------------------------
--VİEW

CREATE OR REPLACE VIEW calisan_detay AS
SELECT
    c.calisan_id,
    k.ad_soyad,
    d.departman_adi,
    p.pozisyon_adi,
    p.pozisyon_tipi,
    m.tutar AS aylik_maas,
    (m.tutar * 12) AS yillik_maas,
    c.ise_giris_tarihi,
    (
        SELECT SUM(ms.masraf_tutari)
        FROM masraf ms
        WHERE ms.calisan_id = c.calisan_id
    ) AS toplam_masraf,
	
    (
        SELECT COUNT(*)
        FROM izin i
        WHERE i.calisan_id = c.calisan_id
    ) AS izin_sayisi

FROM calisan c
JOIN kisi k ON c.kisi_id = k.kisi_id
JOIN pozisyon p ON c.pozisyon_id = p.pozisyon_id
JOIN departman d ON p.departman_id = d.departman_id
JOIN maas m ON c.calisan_id = m.calisan_id;

SELECT *FROM calisan_detay;

