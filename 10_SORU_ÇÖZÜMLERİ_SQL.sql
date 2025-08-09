--🎯 SQL Soru Seti (Veri Analisti + DBA Portföyü için)
--1. Aylara göre toplam satış tutarını listele.
--(Çıktı: Ay, Toplam Satış Tutarı)
--ORDERS.DATE_ üzerinden çalış.
SELECT 
DATEPART(MONTH,DATE_),
SUM(TOTALPRICE) 
FROM ORDERS 
GROUP BY DATEPART(MONTH,DATE_) 
ORDER BY 1 

--2. En çok harcama yapan ilk 5 müşteriyi listele.
--(Çıktı: Müşteri Adı, Toplam Sipariş Sayısı, Toplam Harcama)
--ORDERS.USERID, ORDERDETAILS.TOTALPRICE, USERS.NAMESURNAME kullan.
SELECT TOP 5 
U.NAMESURNAME,
COUNT(O.ID) AS SIPARIS_SAYISI,
SUM(O.TOTALPRICE)AS TOPLAM_HARCAMA
FROM ORDERS O
JOIN USERS U ON U.ID=O.USERID
GROUP BY U.NAMESURNAME
ORDER BY 3 DESC
--3. Her müşterinin ilk ve son sipariş tarihini ve toplam harcamasını göster.
--(Çıktı: Müşteri Adı, İlk Sipariş, Son Sipariş, Toplam Harcama)
--MIN(), MAX(), SUM() ve GROUP BY ile.
SELECT 
U.NAMESURNAME,
MIN(DATE_) AS ILK_SIPARIS_TARIHI,
MAX(DATE_) AS SON_SIPARIS_TARIHI,
SUM(O.TOTALPRICE) AS TOPLAM_HARCAMA 
FROM ORDERS O 
JOIN USERS U ON U.ID=O.USERID
GROUP BY U.NAMESURNAME

--5. En çok satılan ilk 5 ürünü listele.
--(Çıktı: Ürün Adı, Satış Adedi)
--ORDERDETAILS.AMOUNT üzerinden.
SELECT TOP 5 
I.ITEMNAME AS URUN_ISMI,
SUM(OD.AMOUNT)AS SATIS_ADEDI
FROM ORDERDETAILS OD 
JOIN ITEMS I ON I.ID=OD.ITEMID
GROUP BY I.ITEMNAME
ORDER BY 2 DESC
--6. Müşterilerin satın aldıkları toplam ürün adedine göre sıralaması.
--(Çıktı: Müşteri Adı, Toplam Ürün Adedi)
--ORDERDETAILS.AMOUNT + GROUP BY kullanıcı adı.
SELECT
U.NAMESURNAME AS MUSTERI_ADI,
SUM(OD.AMOUNT) AS TOPLAM_URUN_ADEDI
FROM ORDERDETAILS OD 
JOIN ORDERS O ON O.ID=OD.ORDERID
JOIN USERS U ON U.ID=O.USERID
GROUP BY U.NAMESURNAME
--7. Ürün kategorilerine göre toplam satış ve ortalama birim fiyatı göster.
--(Çıktı: Kategori, Toplam Satış, Ortalama Ürün Fiyatı)
--ITEMS.PRICE kullan.
SELECT
I.CATEGORY3,
SUM(OD.LINETOTAL)AS Toplam_SatıS,
AVG(OD.UNITPRICE)AS ORTALAMA_URUN_FIYATI
FROM ITEMS I
JOIN ORDERDETAILS OD ON OD.ITEMID=I.ID
GROUP BY I.CATEGORY3
--8. En fazla farklı ürün satın alan ilk 5 müşteriyi listele.
--(Çıktı: Müşteri Adı, Farklı Ürün Sayısı)
--COUNT(DISTINCT ITEMID) ile.
SELECT
U.NAMESURNAME,
COUNT(DISTINCT I.ID)
FROM ORDERS O 
JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
JOIN ITEMS I ON I.ID=OD.ITEMID
JOIN USERS U ON U.ID=O.USERID
GROUP BY U.NAMESURNAME
--9. Aylık bazda kaç farklı müşteri alışveriş yapmış?
--(Çıktı: Ay, Aktif Müşteri Sayısı)
--DATEPART(MONTH, ORDERS.DATE_), COUNT(DISTINCT USERID)
SELECT
DATEPART(MONTH,O.DATE_),
COUNT(DISTINCT USERID)
FROM ORDERS O
JOIN USERS U ON U.ID=O.USERID
GROUP BY DATEPART(MONTH,DATE_)
ORDER BY 1 
--10. Ürünlerin ortalama satış miktarı ve toplam getirisi (fiyat × adet).
--(Çıktı: Ürün Adı, Ortalama Satış Adedi, Toplam Getiri)
--ORDERDETAILS.AMOUNT, ITEMS.PRICE
SELECT
I.ITEMNAME,
AVG(OD.AMOUNT),
SUM(OD.AMOUNT*OD.UNITPRICE)
FROM ORDERDETAILS OD 
JOIN ITEMS I ON I.ID=OD.ITEMID
GROUP BY I.ITEMNAME