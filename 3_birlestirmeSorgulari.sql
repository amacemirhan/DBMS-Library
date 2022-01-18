-- Klasik veya Psikolojik t�r olanlar�n isimlerini getien komut

Select Distinct KitapAdi From Kitap RIGHT JOIN KitapTur ON Kitap.KitapTurID=KitapTur.KitapTurID
Where Tur='Klasik' OR Tur='Psikolojik' 

Select * from KitapTur where Tur='Klasik' AND Tur='Psikolojik'

-- Hangi t�rden ka� kitap var gruplayan komut

Select Tur,Count(Tur) as miktar From KitapTur Group By Tur

-- 100 ile 200 aras� sayfa say�s� olan kitap say�s�n� veren komut

Select Count(KitapSayfasi) from Kitap where KitapSayfasi between 100 and 200

--Ad Soyad ile id arama

Select OkurId,OkurAdi from Okur Where OkurAdi LIKE '%Paul%'

--Id den ad arama

Select OkurId,OkurAdi from Okur Where OkurID LIKE '13'

--Hangi kitab�n durumunun ne oldu�unu g�steren wiew

Create VIEW Kitap_Durum As
SELECT KitapAdi,Durum 
    FROM Odunc t1
    JOIN Kitap t2 ON t2.KitapID = t1.KitapID

Select * from Kitap_Durum

--Okur ad� ve bulundu�u �ehiri g�steren wiew

Create VIEW Okur_Sehir as
Select OkurAdi,SehirAdi
	FROM Okur t1
	JOIN Sehir t2 ON t1.OkurID=t2.OkurID

Select * from Okur_Sehir

-- Teslim Tarihi ge�enleri Ge�mi� olarak etiketleyen Ko�ul blo�u

Update Odunc Set Durum=
Case when TeslimTarihi IS NOT NULL THEN 'Teslimli'
when Datediff(Day,OduncTarihi,Getdate()) >OduncSuresi THEN 'Ge�mi�'
else 'Okurda'
END ;

-- Fonksiyon test
Select dbo.GunSayisi(92)
Select dbo.GunSayisi(146)
Select dbo.GunSayisi(279)

-- �oktan aza Hangi �lkeden ka� ki�i kayd� var gruplamal�

Select UlkeAdi,Count(UlkeAdi) as [kisi sayisi] From Okur FULL JOIN Sehir ON Okur.OkurID=Sehir.OkurID
FULL JOIN Odunc ON Okur.OkurID=Odunc.OkurID Group By UlkeAdi Order by Count(UlkeAdi) desc


--�� tablo birle�tirme
Select * From Okur FULL JOIN Sehir ON Okur.OkurID=Sehir.OkurID
FULL JOIN Odunc ON Okur.OkurID=Odunc.OkurID


--K�t�phanede bulunan kitaplarla ilgili istatistikler

Select Count(KitapID) as [ka� adet kitap],
Sum(KitapSayfasi) as [Toplam yaz�l� sayfa sayisi],
AVG(KitapSayfasi) as [Ortalama kitap kal�nl���],
Max(KitapSayfasi) as [En b�y�k kitap],
Min(KitapSayfasi) as [En k���k kitap]
from Kitap

--En b�y�k kitab�n ad� i� i�e sorgular

Select KitapAdi from Kitap where KitapSayfasi=(Select Max(KitapSayfasi) From Kitap)

--Kitap tur ile kitap tablosunu birle�tirir

select * from Kitap FULL JOIN KitapTur ON KitapTur.KitapTurID=Kitap.KitapTurID

--Transaction �rne�i

BEGIN TRANSACTION
exec RandomOduncal 13,'Dey138'
exec teslimet 6,'Sef112'
COMMIT TRANSACTION

--teslim tarihi ge�enlerin numaralar�n� ve emaillerini veren sorgu

Select OkurAdi,OkurTelNo,OkurEmail from Okur JOIN Odunc ON Okur.OkurID=Odunc.OkurID
where Durum='Ge�mi�'

--okurlar�n ka� g�n kitap okuduklar�n� g�steren sorgu

Select OkurAdi,DateDiff(day,OduncTarihi,TeslimTarihi) as [Kitap okunan g�n say�s�] 
from Okur JOIN Odunc ON Okur.OkurID=Odunc.OkurID
where Durum='Teslimli'





