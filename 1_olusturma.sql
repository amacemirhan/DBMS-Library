CREATE TABLE Okur (
    OkurID INT PRIMARY KEY IDENTITY(1,1),
    OkurAdi VARCHAR(50),
    OkurTelNo VARCHAR(10),
    OkurEmail VARCHAR(30)
);
CREATE TABLE Kitap (
    KitapID VARCHAR(6) PRIMARY KEY,
    KitapAdi VARCHAR(50),
    KitapTurID Int FOREIGN KEY REFERENCES KitapTur (KitapTurID),
    KitapYazari VARCHAR(30),
	KitapSayfasi INT
);

CREATE TABLE KitapTur (
    KitapTurID Int,
	Tur Varchar(50)
);

CREATE TABLE Odunc (
	OkurID INT,
	KitapID VARCHAR(6),
	OduncSuresi INT,
	OduncTarihi DATE
);
DROP TABLE Okur
ALTER TABLE Okur
MODIFY OkurID int IDENTITY(1,1) 

ALTER TABLE KitapTur
ADD CONSTRAINT UC_Ktur UNIQUE (KitapTurID,Tur);


Select * From Kitap
Select * From KitapTur

INSERT INTO Kitap
VALUES ('SVC504','Suç Ve Ceza',1,'Fyodor Dostoyevski','504')
INSERT INTO KitapTur
VALUES (1,'Roman'),(1,'Klasik'),(1,'Psikolojik');


INSERT INTO Okur (OkurAdi,OkurTelNo,OkurEmail)
VALUES ('Mehmed Emirhan Amaç','5524365382','emirhan_amac01@hotmail.com')
,('Osman Demir','5594375382','osmnys@gmail.com')
,('Mahmut Turuncu','5524375382','mhmttrnc@gmail.com');
Select * from Okur

UPDATE Okur
SET OkurAdi = 'Mehmed Emirhan Amaç'
WHERE OkurID=123;

Select * from Okur

DELETE FROM Okur WHERE OkurAdi='Mehmed Emirhan Amaç';

SELECT *
FROM Okur
WHERE OkurAdi IN ('Osman Demir', 'Mahmut Turuncu');

Select * from Okur
SELECT DISTINCT OkurAdi from Okur

Select * from Okur2

SELECT OkurAdi FROM Okur
UNION
SELECT OkurAdi FROM Okur2;

Select OkurAdi from Okur WHERE EXISTS(Select * from Okur Where OkurAdi='Emirhan Amaç')

SELECT *
INTO Okur3
FROM Okur

Select * from Okur3

--gmail kullananlar

SELECT OkurAdi
FROM Okur
WHERE OkurEmail LIKE '%gmail.com';

Select * from Kitap

