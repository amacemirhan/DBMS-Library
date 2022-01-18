INSERT INTO Kitap
VALUES 
('Vat96','Vatan Yahut Silistre',1,'Namýk Kemal',96),
('Tom120','Tom Amca’nýn Kulübesi',2,'Harriet Beecher Stowe',120),
('Bad231','Badem Operasyonu',3,'Melek Çe',231),
('Sef112','Sefiller',4,'Victor Hugo',112),
('Uça188','Uçan Sýnýf',5,'Erich Kastner',188),
('Vat247','Vatan Yahut Silistre',6,'Namýk Kemal',247),
('Val232','Valideki Zambak',7,'Honore De Balzac',232),
('Yaþ104','Yaþlý Balýkçý Ve Deniz',8,'Ernest Hemingway',104),
('Bil93','Billur Köþk Masallarý',9,'Tuba Öztürk',93),
('Muc173','Mucitler ve Ýcat Öyküleri',10,'Çiðdem Can',173),
('Bel239','Belrli Günler ve Haftalar',11,'Cuma Karataþ',239),
('80 103','80 Günde Devri Alem',12,'Jules Verne',103),
('Per160','Perili Köþk',13,'Ömer Seyfettin ',160),
('Dey138','Deyimler ve Öyküler',14,'Selim Gündüzalp',138),
('Mut208','Mutluluk Öyküleri',15,'Murat Çiftkaya \ Senai Demirci',208),
('Þek182','Þeker Portakalý',16,'Jose Mauro De Vasconcelos',182),
('Top159','Topuz',17,'Ömer Seyfettin',159),
('Aga187','Aganta Burina Burinata',18,'Halikarnas Balýkçýsý',187),
('Far110','Fareler ve Ýnsanlar',19,'John Steinbeck',110),
('Yun192','Yunus Emre’den Seçmeler',20,'Yunus Emre',192);

INSERT INTO Kitap
VALUES ('SVC504','Suç Ve Ceza',1,'Fyodor Dostoyevski',504)

Update Kitap
SET KitapTurID=21
where KitapID='SVC504'

INSERT INTO KitapTur
VALUES (21,'Roman'),(21,'Klasik'),(21,'Psikolojik'),
(2,'Hikaye'),(2,'Çocuk'),(3,'Destan'),(4,'Klasik'),(4,'Hüzünlü'),
(5,'Hikaye'),(5,'Çocuk'),(5,'Macera'),(6,'Roman'),(12,'Macera');

INSERT INTO KitapTur
VALUES (16,'Roman'),(15,'Klasik'),(4,'Psikolojik'),
(9,'Hikaye'),(11,'Çocuk'),(3,'Destan'),(4,'Klasik'),(4,'Hüzünlü'),
(5,'Hikaye'),(5,'Çocuk'),(5,'Macera'),(6,'Roman'),(12,'Macera');


Delete * From Kitap
Select * From Kitap
Select * From KitapTur

--içinde Fonksiyon barýndýran Kitap ödünç almaya yarayan Stored produce 

CREATE PROC oduncal @okId Int,@kitID nvarchar(6)
as
declare @KitSay int
Set @KitSay = (Select KitapSayfasi from Kitap Where KitapID=@kitID)
INSERT INTO Odunc
Values
(@okId,@kitID,dbo.GunSayisi(@KitSay),getdate(),'Okurda',NULL)
GO

exec oduncal 1,'Þek182'
exec oduncal 2,'Bil93'

--random belirli iki tarih arasý rastgele bir gün ödünç alma sp'u
CREATE PROC RandomOduncal @okId Int,@kitID nvarchar(6)
as
declare @KitSay int
Set @KitSay = (Select KitapSayfasi from Kitap Where KitapID=@kitID)
declare @randate date
Declare @DateStart	Date = '2021-12-01'
		,@DateEnd	Date = '2022-01-01'

set @randate = (Select DateAdd(Day, Rand() * DateDiff(Day, @DateStart, @DateEnd), @DateStart))
print @randate
INSERT INTO Odunc
Values
(@okId,@kitID,dbo.GunSayisi(@KitSay),@randate,'Okurda',NULL)
GO

exec RandomOduncal 3,'Top159'
exec RandomOduncal 5,'Per160'
exec RandomOduncal 6,'Sef112'
exec RandomOduncal 7,'SVC504'
exec RandomOduncal 8,'Þek182'
exec RandomOduncal 9,'Val232'
exec RandomOduncal 12,'Yun192'

-- Teslim etmeye yarayan stored produce 
CREATE PROC teslimet @okId Int,@kitID nvarchar(6)
as
Update Odunc
Set Durum = 'Teslimli' , TeslimTarihi = Getdate() where OkurID=@okId AND KitapID=@kitID
GO

exec teslimet 1,'Þek182'

--Kitap Sayfasýnýn çokluða göre ödünç alýnma gün miktarýný belirleyen fonksiyon.

Create Function GunSayisi
(@KitSay int)
returns int
as
Begin
	IF (@KitSay > 100 AND @KitSay < 200)
		Set @Gun = 20
	ELSE IF (@KitSay < 100)
		Set @Gun = 10
	ELSE
		Set @Gun = 30
	RETURN @Gun
END

--kitap tür ekleyen sp
CREATE PROC turekle @kitTurId Int,@Tur nvarchar(15)
as
INSERT INTO KitapTur VALUES(@kitTurId,@Tur)
GO

exec turekle 7,'Hikaye'

--Thanks generatedata.com
INSERT INTO Okur (OkurAdi,OkurTelNo,OkurEmail)
VALUES 
('Yüksel Coþar','5574315382','ycosar@yahoo.com'),
('Tuncel Arslan','5214375982','tuncelarsln@yahoo.com'),
('Ayþa Kulin','5524075982','aysknlm@gmail.com'),
 ('Buffy Patterson','5365155146','malesuada@outlook.com'),
  ('James Little','5341313688','vivamus.non.lorem@yahoo.ca'),
  ('Ignacia Johnston','5501660927','felis.adipiscing@hotmail.com'),
  ('Samantha Gross','5332249847','vestibulum.neque.sed@protonmail.org'),
  ('Kenyon Walsh','5510018675','dictum.augue@hotmail.net'),
  ('Ariana Marks','5259761750','justo@outlook.couk'),
  ('Kenyon Martin','5271726164','tempus@icloud.couk'),
  ('Mary Orr','5234793276','sem.vitae@aol.com'),
  ('Kelsie Kane','5322175667','magna.praesent@outlook.net'),
  ('Eve Hicks','5316194418','sem@yahoo.ca'),
  ('Josephine Hooper','5322621825','egestas.ligula.nullam@google.ca'),
  ('Kasper Collins','5387416229','nam.consequat@aol.org'),
  ('Ahmed Acosta','5212191891','elit.curabitur@outlook.edu'),
  ('Scarlet Rios','5278265875','ultricies@yahoo.edu'),
  ('Galena Harrington','5367021764','ipsum.non@hotmail.net'),
  ('Leila Kent','5571616804','ultricies.adipiscing.enim@protonmail.couk'),
  ('Lareina Barlow','5311067748','luctus@protonmail.edu'),
  ('Fulton Whitaker','5342178925','sed.malesuada@aol.com'),
  ('Olympia Wilder','5239456325','auctor.velit@hotmail.org'),
  ('Vaughan Cherry','5353954600','donec.non@google.ca'),
  ('Logan Horton','5525077432','malesuada.fames@yahoo.ca'),
  ('Linus Vaughan','5357783883','dui@icloud.org'),
  ('Hunter Mcfarland','5342136158','nulla.in.tincidunt@outlook.edu'),
  ('Maris Frazier','5355463749','cursus.nunc@yahoo.edu'),
  ('Travis Marsh','5558234268','fermentum.risus@hotmail.edu'),
  ('Cameron Turner','5316665502','dolor@protonmail.ca'),
  ('Morgan Daniels','5533781776','hendrerit.neque@hotmail.org'),
  ('Kelsie Trevino','5551926116','non.lacinia@yahoo.couk'),
  ('Germaine Moody','5531443156','pede.ultrices@aol.ca'),
  ('Paul Dennis','5395254473','leo@google.edu'),
  ('Ross Irwin','5339125467','fringilla.purus@aol.net'),
  ('Velma Owens','5218539176','nulla.cras@protonmail.edu'),
  ('Katelyn Patrick','5358112883','magnis.dis@protonmail.ca'),
  ('Quyn Barrera','5549494007','volutpat.nunc.sit@protonmail.couk'),
  ('Vielka Williamson','5368598374','elementum.dui@protonmail.net'),
  ('Aurora Gonzales','5387942218','placerat.eget.venenatis@yahoo.ca'),
  ('Xanthus Dawson','5252576631','semper@google.couk'),
  ('Uta Hines','5557341234','nisl.nulla@outlook.net'),
  ('Wyoming Dickerson','5219443727','neque.sed@aol.edu'),
  ('Tanek Barnett','5324411335','turpis.nec@icloud.org'),
  ('Harriet Rice','5298111236','phasellus@icloud.edu'),
  ('Simon Frank','5263200744','ut.nulla@outlook.edu'),
  ('Magee Sloan','5240241648','pellentesque.massa.lobortis@icloud.org'),
  ('Rae Mckee','5243676623','sed@aol.net'),
  ('Ralph Watts','5265585964','mi.fringilla@yahoo.couk'),
  ('Kerry Francis','5553392246','rutrum.urna@outlook.org'),
  ('Chiquita Dotson','5367063647','ornare.in@hotmail.edu'),
  ('Mohammad Mcfadden','5528605287','montes@outlook.edu'),
  ('Dorian Dunlap','5334624166','nulla.integer.urna@aol.net'),
  ('Eve Suarez','5341318544','nullam.ut@yahoo.com'),
   ('Wing Gardner','5318657503','convallis.ligula@hotmail.com'),
  ('Pamela Guy','5561521582','lorem.ac.risus@hotmail.edu'),
  ('Ann Roberts','5508272062','ut.aliquam@outlook.net'),
  ('Mia Marshall','5584141296','facilisis.vitae.orci@hotmail.com'),
  ('Ayanna Rivers','5395353648','mauris@yahoo.com'),
  ('Macy Dale','5558911381','semper.nam@outlook.couk'),
  ('Kibo Joyce','5281284568','ultrices.a@protonmail.org'),
  ('Isaiah Lloyd','5526522818','sapien.molestie.orci@icloud.net'),
  ('Denise Conley','5252144285','sollicitudin.adipiscing.ligula@yahoo.net'),
  ('Hunter Shields','5257477184','ut.pellentesque@aol.ca'),
  ('Jeanette Cash','5348397652','turpis@aol.edu'),
  ('Walter Norris','5503382232','pede.suspendisse@hotmail.com'),
  ('Otto Duncan','5240548410','quisque.ac@aol.net'),
  ('Jin Cannon','5256441299','penatibus.et@aol.ca'),
  ('Kitra Pitts','5338822515','sed.nec@google.net'),
  ('Magee Grimes','5550574148','non.vestibulum.nec@google.org'),
  ('Marah Palmer','5262399531','curabitur.ut.odio@aol.org'),
  ('Kyla Fletcher','5511976595','suspendisse@hotmail.org'),
  ('Stewart Forbes','5544722714','nunc@aol.org'),
  ('Carson Lawson','5277415871','tristique.pharetra@hotmail.net'),
   ('Wayne Delacruz','5288875345','mus.aenean@protonmail.com'),
  ('Priscilla Washington','5235221290','augue.porttitor.interdum@protonmail.ca'),
  ('Kenneth Compton','5328528316','tellus@protonmail.net'),
  ('Wendy Hart','5521071541','suspendisse.commodo.tincidunt@protonmail.couk'),
  ('Kylan Blair','5338653024','praesent@aol.org'),
  ('Judah Lopez','5532657142','turpis@outlook.org'),
  ('Justina Walton','5377910360','lorem.sit@outlook.net'),
  ('Yuri Yates','5505810584','tincidunt.orci@icloud.net'),
  ('Jasmine Robles','5265252187','montes.nascetur@outlook.ca'),
  ('Genevieve Eaton','5217723348','malesuada.vel@outlook.com'),
  ('Garth Richardson','5516794465','lacus.cras.interdum@outlook.com'),
  ('Serina Daugherty','5234857323','ullamcorper.duis@yahoo.couk'),
  ('Myra Howe','5272439132','cras.dolor@outlook.org'),
  ('Veronica Valenzuela','5327731241','nec.cursus@icloud.couk'),
  ('Roth Day','5578818755','at.iaculis.quis@icloud.ca'),
  ('Jade Richards','5347375524','dis.parturient@protonmail.org'),
  ('Lionel Guerra','5522464228','ut@outlook.ca'),
  ('Ferdinand Sherman','5392623887','sodales.elit@hotmail.org'),
  ('Abra Carson','5313408360','vestibulum.ante.ipsum@icloud.edu'),
  ('Orlando Nash','5356260718','conubia.nostra.per@protonmail.com'),
  ('Damian Steele','5387236866','elit@hotmail.com'),
  ('Nina Juarez','5339955763','fringilla.purus@protonmail.net'),
  ('Jescie Mercer','5274852159','orci.lobortis@protonmail.net'),
  ('Tanner Mckinney','5584358430','enim.suspendisse@yahoo.couk'),
  ('Melodie Faulkner','5323566524','dolor.vitae@hotmail.net'),
  ('Megan Petersen','5303734467','et.netus.et@yahoo.com'),
  ('Alexandra Bowers','5544023940','mauris.non@hotmail.couk'),
  ('Amery Cote','5237761032','libero@aol.couk'),
  ('Ivory Bradley','5265617038','auctor.non@aol.ca'),
  ('Gail Hood','5227766273','dui.nec@outlook.net');
