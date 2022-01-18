-- Klasik veya Psikolojik tür olanlarýn isimlerini getien komut

Select Distinct KitapAdi From Kitap RIGHT JOIN KitapTur ON Kitap.KitapTurID=KitapTur.KitapTurID
Where Tur='Klasik' OR Tur='Psikolojik' 

Select * from KitapTur where Tur='Klasik' AND Tur='Psikolojik'

-- Hangi türden kaç kitap var gruplayan komut

Select Tur,Count(Tur) as miktar From KitapTur Group By Tur

-- 100 ile 200 arasý sayfa sayýsý olan kitap sayýsýný veren komut

Select Count(KitapSayfasi) from Kitap where KitapSayfasi between 100 and 200

--Ad Soyad ile id arama

Select OkurId,OkurAdi from Okur Where OkurAdi LIKE '%Paul%'

--Id den ad arama

Select OkurId,OkurAdi from Okur Where OkurID LIKE '13'

--Hangi kitabýn durumunun ne olduðunu gösteren wiew

Create VIEW Kitap_Durum As
SELECT KitapAdi,Durum 
    FROM Odunc t1
    JOIN Kitap t2 ON t2.KitapID = t1.KitapID

Select * from Kitap_Durum

--Okur adý ve bulunduðu þehiri gösteren wiew

Create VIEW Okur_Sehir as
Select OkurAdi,SehirAdi
	FROM Okur t1
	JOIN Sehir t2 ON t1.OkurID=t2.OkurID

Select * from Okur_Sehir

-- Teslim Tarihi geçenleri Geçmiþ olarak etiketleyen Koþul bloðu

Update Odunc Set Durum=
Case when TeslimTarihi IS NOT NULL THEN 'Teslimli'
when Datediff(Day,OduncTarihi,Getdate()) >OduncSuresi THEN 'Geçmiþ'
else 'Okurda'
END ;

-- Fonksiyon test
Select dbo.GunSayisi(92)
Select dbo.GunSayisi(146)
Select dbo.GunSayisi(279)

-- Çoktan aza Hangi ülkeden kaç kiþi kaydý var gruplamalý

Select UlkeAdi,Count(UlkeAdi) as [kisi sayisi] From Okur FULL JOIN Sehir ON Okur.OkurID=Sehir.OkurID
FULL JOIN Odunc ON Okur.OkurID=Odunc.OkurID Group By UlkeAdi Order by Count(UlkeAdi) desc


--üç tablo birleþtirme
Select * From Okur FULL JOIN Sehir ON Okur.OkurID=Sehir.OkurID
FULL JOIN Odunc ON Okur.OkurID=Odunc.OkurID


--Kütüphanede bulunan kitaplarla ilgili istatistikler

Select Count(KitapID) as [kaç adet kitap],
Sum(KitapSayfasi) as [Toplam yazýlý sayfa sayisi],
AVG(KitapSayfasi) as [Ortalama kitap kalýnlýðý],
Max(KitapSayfasi) as [En büyük kitap],
Min(KitapSayfasi) as [En küçük kitap]
from Kitap

--En büyük kitabýn adý iç içe sorgular

Select KitapAdi from Kitap where KitapSayfasi=(Select Max(KitapSayfasi) From Kitap)

--Kitap tur ile kitap tablosunu birleþtirir

select * from Kitap FULL JOIN KitapTur ON KitapTur.KitapTurID=Kitap.KitapTurID

--Transaction örneði

BEGIN TRANSACTION
exec RandomOduncal 13,'Dey138'
exec teslimet 6,'Sef112'
COMMIT TRANSACTION

--teslim tarihi geçenlerin numaralarýný ve emaillerini veren sorgu

Select OkurAdi,OkurTelNo,OkurEmail from Okur JOIN Odunc ON Okur.OkurID=Odunc.OkurID
where Durum='Geçmiþ'

--okurlarýn kaç gün kitap okuduklarýný gösteren sorgu

Select OkurAdi,DateDiff(day,OduncTarihi,TeslimTarihi) as [Kitap okunan gün sayýsý] 
from Okur JOIN Odunc ON Okur.OkurID=Odunc.OkurID
where Durum='Teslimli'





