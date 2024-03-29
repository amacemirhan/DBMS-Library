USE [master]
GO
/****** Object:  Database [Library]    Script Date: 18.01.2022 17:35:43 ******/
CREATE DATABASE [Library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Library_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Library_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Library] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library] SET RECOVERY FULL 
GO
ALTER DATABASE [Library] SET  MULTI_USER 
GO
ALTER DATABASE [Library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Library] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Library] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Library', N'ON'
GO
ALTER DATABASE [Library] SET QUERY_STORE = OFF
GO
USE [Library]
GO
/****** Object:  UserDefinedFunction [dbo].[GunSayisi]    Script Date: 18.01.2022 17:35:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[GunSayisi]
(@KitSay int)
returns int
as
Begin
	Declare @gun int
	IF (@KitSay > 100 AND @KitSay < 200)
		Set @Gun = 20
	ELSE IF (@KitSay < 100)
		Set @Gun = 10
	ELSE
		Set @Gun = 30
	RETURN @Gun
END
GO
/****** Object:  Table [dbo].[Kitap]    Script Date: 18.01.2022 17:35:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kitap](
	[KitapID] [varchar](6) NOT NULL,
	[KitapAdi] [varchar](50) NULL,
	[KitapTurID] [int] NULL,
	[KitapYazari] [varchar](30) NULL,
	[KitapSayfasi] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[KitapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Odunc]    Script Date: 18.01.2022 17:35:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Odunc](
	[OkurID] [int] NOT NULL,
	[KitapID] [varchar](6) NOT NULL,
	[OduncSuresi] [int] NULL,
	[OduncTarihi] [date] NULL,
	[Durum] [varchar](10) NULL,
	[TeslimTarihi] [date] NULL,
 CONSTRAINT [PK_Odunc] PRIMARY KEY CLUSTERED 
(
	[OkurID] ASC,
	[KitapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Kitap_Durum]    Script Date: 18.01.2022 17:35:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIEW [dbo].[Kitap_Durum] As
SELECT KitapAdi,Durum 
    FROM Odunc t1
    JOIN Kitap t2 ON t2.KitapID = t1.KitapID
GO
/****** Object:  Table [dbo].[Okur]    Script Date: 18.01.2022 17:35:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Okur](
	[OkurID] [int] IDENTITY(1,1) NOT NULL,
	[OkurAdi] [varchar](50) NULL,
	[OkurTelNo] [varchar](10) NULL,
	[OkurEmail] [varchar](70) NULL,
 CONSTRAINT [PK__Okur__F2C0255A27A01AB6] PRIMARY KEY CLUSTERED 
(
	[OkurID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sehir]    Script Date: 18.01.2022 17:35:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sehir](
	[OkurID] [int] IDENTITY(1,1) NOT NULL,
	[SehirAdi] [varchar](255) NULL,
	[Adress] [varchar](255) NULL,
	[UlkeAdi] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[OkurID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Okur_Sehir]    Script Date: 18.01.2022 17:35:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIEW [dbo].[Okur_Sehir] as
Select OkurAdi,SehirAdi
	FROM Okur t1
	JOIN Sehir t2 ON t1.OkurID=t2.OkurID
GO
/****** Object:  Table [dbo].[KitapTur]    Script Date: 18.01.2022 17:35:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KitapTur](
	[KitapTurID] [int] NOT NULL,
	[Tur] [varchar](50) NOT NULL,
 CONSTRAINT [PK_KitapTur] PRIMARY KEY CLUSTERED 
(
	[KitapTurID] ASC,
	[Tur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'80 103', N'80 Günde Devri Alem', 12, N'Jules Verne', 103)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Aga187', N'Aganta Burina Burinata', 18, N'Halikarnas Balıkçısı', 187)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Bad231', N'Badem Operasyonu', 3, N'Melek Çe', 231)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Bel239', N'Belrli Günler ve Haftalar', 11, N'Cuma Karataş', 239)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Bil93', N'Billur Köşk Masalları', 9, N'Tuba Öztürk', 93)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Dey138', N'Deyimler ve Öyküler', 14, N'Selim Gündüzalp', 138)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Far110', N'Fareler ve İnsanlar', 19, N'John Steinbeck', 110)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Muc173', N'Mucitler ve İcat Öyküleri', 10, N'Çiğdem Can', 173)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Mut208', N'Mutluluk Öyküleri', 15, N'Murat Çiftkaya \ Senai Demirci', 208)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Per160', N'Perili Köşk', 13, N'Ömer Seyfettin ', 160)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Sef112', N'Sefiller', 4, N'Victor Hugo', 112)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'SVC504', N'Suç Ve Ceza', 21, N'Fyodor Dostoyevski', 504)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Şek182', N'Şeker Portakalı', 16, N'Jose Mauro De Vasconcelos', 182)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Tom120', N'Tom Amca’nın Kulübesi', 2, N'Harriet Beecher Stowe', 120)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Top159', N'Topuz', 17, N'Ömer Seyfettin', 159)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Uça188', N'Uçan Sınıf', 5, N'Erich Kastner', 188)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Val232', N'Valideki Zambak', 7, N'Honore De Balzac', 232)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Vat247', N'Vatan Yahut Silistre', 6, N'Namık Kemal', 247)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Vat96', N'Vatan Yahut Silistre', 1, N'Namık Kemal', 96)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Yaş104', N'Yaşlı Balıkçı Ve Deniz', 8, N'Ernest Hemingway', 104)
INSERT [dbo].[Kitap] ([KitapID], [KitapAdi], [KitapTurID], [KitapYazari], [KitapSayfasi]) VALUES (N'Yun192', N'Yunus Emre’den Seçmeler', 20, N'Yunus Emre', 192)
GO
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (1, N'Klasik')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (1, N'Psikolojik')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (1, N'Roman')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (2, N'Çocuk')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (2, N'Hikaye')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (3, N'Destan')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (4, N'Hüzünlü')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (4, N'Klasik')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (5, N'Çocuk')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (5, N'Hikaye')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (5, N'Macera')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (6, N'Roman')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (7, N'Hikaye')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (9, N'Şiir')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (11, N'Ansiklopedi')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (12, N'Macera')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (13, N'Macera')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (13, N'Psikolojik')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (13, N'Roman')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (14, N'Komik')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (21, N'Klasik')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (21, N'Psikolojik')
INSERT [dbo].[KitapTur] ([KitapTurID], [Tur]) VALUES (21, N'Roman')
GO
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (1, N'Şek182', 15, CAST(N'2021-12-27' AS Date), N'Teslimli', CAST(N'2022-01-02' AS Date))
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (2, N'Bil93', 10, CAST(N'2022-01-02' AS Date), N'Okurda', NULL)
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (3, N'Top159', 20, CAST(N'2021-12-03' AS Date), N'Geçmiş', NULL)
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (5, N'Per160', 20, CAST(N'2021-12-06' AS Date), N'Geçmiş', NULL)
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (6, N'Sef112', 20, CAST(N'2021-12-05' AS Date), N'Geçmiş', NULL)
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (7, N'SVC504', 30, CAST(N'2021-12-11' AS Date), N'Okurda', NULL)
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (8, N'Şek182', 20, CAST(N'2021-12-24' AS Date), N'Okurda', NULL)
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (9, N'Val232', 30, CAST(N'2021-12-12' AS Date), N'Okurda', NULL)
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (12, N'Yun192', 20, CAST(N'2021-12-08' AS Date), N'Teslimli', CAST(N'2022-01-04' AS Date))
INSERT [dbo].[Odunc] ([OkurID], [KitapID], [OduncSuresi], [OduncTarihi], [Durum], [TeslimTarihi]) VALUES (27, N'Dey138', 20, CAST(N'2021-12-13' AS Date), N'Teslimli', CAST(N'2022-01-04' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Okur] ON 

INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (1, N'Mahmut Turuncu', N'5524375382', N'mhmttrnc@gmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (2, N'Emirhan Amaç', N'5524365382', N'emirhan_amac01@hotmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (3, N'Osman Demir', N'5594375382', N'osmnys@gmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (4, N'Emirhan Amaç', N'5524365382', N'emirhan_amac01@hotmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (5, N'Yüksel Coşar', N'5574315382', N'ycosar@yahoo.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (6, N'Tuncel Arslan', N'5214375982', N'tuncelarsln@yahoo.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (7, N'Ayşa Kulin', N'5524075982', N'aysknlm@gmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (8, N'Buffy Patterson', N'5365155146', N'malesuada@outlook.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (9, N'James Little', N'5341313688', N'vivamus.non.lorem@yahoo.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (10, N'Ignacia Johnston', N'5501660927', N'felis.adipiscing@hotmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (11, N'Samantha Gross', N'5332249847', N'vestibulum.neque.sed@protonmail.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (12, N'Kenyon Walsh', N'5510018675', N'dictum.augue@hotmail.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (13, N'Ariana Marks', N'5259761750', N'justo@outlook.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (14, N'Kenyon Martin', N'5271726164', N'tempus@icloud.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (15, N'Mary Orr', N'5234793276', N'sem.vitae@aol.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (16, N'Kelsie Kane', N'5322175667', N'magna.praesent@outlook.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (17, N'Eve Hicks', N'5316194418', N'sem@yahoo.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (18, N'Josephine Hooper', N'5322621825', N'egestas.ligula.nullam@google.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (19, N'Kasper Collins', N'5387416229', N'nam.consequat@aol.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (20, N'Ahmed Acosta', N'5212191891', N'elit.curabitur@outlook.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (21, N'Scarlet Rios', N'5278265875', N'ultricies@yahoo.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (22, N'Galena Harrington', N'5367021764', N'ipsum.non@hotmail.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (23, N'Leila Kent', N'5571616804', N'ultricies.adipiscing.enim@protonmail.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (24, N'Lareina Barlow', N'5311067748', N'luctus@protonmail.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (25, N'Fulton Whitaker', N'5342178925', N'sed.malesuada@aol.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (26, N'Olympia Wilder', N'5239456325', N'auctor.velit@hotmail.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (27, N'Vaughan Cherry', N'5353954600', N'donec.non@google.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (28, N'Logan Horton', N'5525077432', N'malesuada.fames@yahoo.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (29, N'Linus Vaughan', N'5357783883', N'dui@icloud.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (30, N'Hunter Mcfarland', N'5342136158', N'nulla.in.tincidunt@outlook.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (31, N'Maris Frazier', N'5355463749', N'cursus.nunc@yahoo.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (32, N'Travis Marsh', N'5558234268', N'fermentum.risus@hotmail.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (33, N'Cameron Turner', N'5316665502', N'dolor@protonmail.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (34, N'Morgan Daniels', N'5533781776', N'hendrerit.neque@hotmail.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (35, N'Kelsie Trevino', N'5551926116', N'non.lacinia@yahoo.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (36, N'Germaine Moody', N'5531443156', N'pede.ultrices@aol.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (37, N'Paul Dennis', N'5395254473', N'leo@google.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (38, N'Ross Irwin', N'5339125467', N'fringilla.purus@aol.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (39, N'Velma Owens', N'5218539176', N'nulla.cras@protonmail.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (40, N'Katelyn Patrick', N'5358112883', N'magnis.dis@protonmail.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (41, N'Quyn Barrera', N'5549494007', N'volutpat.nunc.sit@protonmail.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (42, N'Vielka Williamson', N'5368598374', N'elementum.dui@protonmail.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (43, N'Aurora Gonzales', N'5387942218', N'placerat.eget.venenatis@yahoo.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (44, N'Xanthus Dawson', N'5252576631', N'semper@google.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (45, N'Uta Hines', N'5557341234', N'nisl.nulla@outlook.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (46, N'Wyoming Dickerson', N'5219443727', N'neque.sed@aol.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (47, N'Tanek Barnett', N'5324411335', N'turpis.nec@icloud.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (48, N'Harriet Rice', N'5298111236', N'phasellus@icloud.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (49, N'Simon Frank', N'5263200744', N'ut.nulla@outlook.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (50, N'Magee Sloan', N'5240241648', N'pellentesque.massa.lobortis@icloud.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (51, N'Rae Mckee', N'5243676623', N'sed@aol.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (52, N'Ralph Watts', N'5265585964', N'mi.fringilla@yahoo.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (53, N'Kerry Francis', N'5553392246', N'rutrum.urna@outlook.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (54, N'Chiquita Dotson', N'5367063647', N'ornare.in@hotmail.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (55, N'Mohammad Mcfadden', N'5528605287', N'montes@outlook.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (56, N'Dorian Dunlap', N'5334624166', N'nulla.integer.urna@aol.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (57, N'Eve Suarez', N'5341318544', N'nullam.ut@yahoo.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (58, N'Wing Gardner', N'5318657503', N'convallis.ligula@hotmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (59, N'Pamela Guy', N'5561521582', N'lorem.ac.risus@hotmail.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (60, N'Ann Roberts', N'5508272062', N'ut.aliquam@outlook.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (61, N'Mia Marshall', N'5584141296', N'facilisis.vitae.orci@hotmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (62, N'Ayanna Rivers', N'5395353648', N'mauris@yahoo.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (63, N'Macy Dale', N'5558911381', N'semper.nam@outlook.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (64, N'Kibo Joyce', N'5281284568', N'ultrices.a@protonmail.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (65, N'Isaiah Lloyd', N'5526522818', N'sapien.molestie.orci@icloud.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (66, N'Denise Conley', N'5252144285', N'sollicitudin.adipiscing.ligula@yahoo.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (67, N'Hunter Shields', N'5257477184', N'ut.pellentesque@aol.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (68, N'Jeanette Cash', N'5348397652', N'turpis@aol.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (69, N'Walter Norris', N'5503382232', N'pede.suspendisse@hotmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (70, N'Otto Duncan', N'5240548410', N'quisque.ac@aol.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (71, N'Jin Cannon', N'5256441299', N'penatibus.et@aol.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (72, N'Kitra Pitts', N'5338822515', N'sed.nec@google.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (73, N'Magee Grimes', N'5550574148', N'non.vestibulum.nec@google.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (74, N'Marah Palmer', N'5262399531', N'curabitur.ut.odio@aol.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (75, N'Kyla Fletcher', N'5511976595', N'suspendisse@hotmail.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (76, N'Stewart Forbes', N'5544722714', N'nunc@aol.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (77, N'Carson Lawson', N'5277415871', N'tristique.pharetra@hotmail.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (78, N'Wayne Delacruz', N'5288875345', N'mus.aenean@protonmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (79, N'Priscilla Washington', N'5235221290', N'augue.porttitor.interdum@protonmail.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (80, N'Kenneth Compton', N'5328528316', N'tellus@protonmail.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (81, N'Wendy Hart', N'5521071541', N'suspendisse.commodo.tincidunt@protonmail.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (82, N'Kylan Blair', N'5338653024', N'praesent@aol.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (83, N'Judah Lopez', N'5532657142', N'turpis@outlook.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (84, N'Justina Walton', N'5377910360', N'lorem.sit@outlook.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (85, N'Yuri Yates', N'5505810584', N'tincidunt.orci@icloud.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (86, N'Jasmine Robles', N'5265252187', N'montes.nascetur@outlook.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (87, N'Genevieve Eaton', N'5217723348', N'malesuada.vel@outlook.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (88, N'Garth Richardson', N'5516794465', N'lacus.cras.interdum@outlook.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (89, N'Serina Daugherty', N'5234857323', N'ullamcorper.duis@yahoo.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (90, N'Myra Howe', N'5272439132', N'cras.dolor@outlook.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (91, N'Veronica Valenzuela', N'5327731241', N'nec.cursus@icloud.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (92, N'Roth Day', N'5578818755', N'at.iaculis.quis@icloud.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (93, N'Jade Richards', N'5347375524', N'dis.parturient@protonmail.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (94, N'Lionel Guerra', N'5522464228', N'ut@outlook.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (95, N'Ferdinand Sherman', N'5392623887', N'sodales.elit@hotmail.org')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (96, N'Abra Carson', N'5313408360', N'vestibulum.ante.ipsum@icloud.edu')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (97, N'Orlando Nash', N'5356260718', N'conubia.nostra.per@protonmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (98, N'Damian Steele', N'5387236866', N'elit@hotmail.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (99, N'Nina Juarez', N'5339955763', N'fringilla.purus@protonmail.net')
GO
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (100, N'Jescie Mercer', N'5274852159', N'orci.lobortis@protonmail.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (101, N'Tanner Mckinney', N'5584358430', N'enim.suspendisse@yahoo.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (102, N'Melodie Faulkner', N'5323566524', N'dolor.vitae@hotmail.net')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (103, N'Megan Petersen', N'5303734467', N'et.netus.et@yahoo.com')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (104, N'Alexandra Bowers', N'5544023940', N'mauris.non@hotmail.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (105, N'Amery Cote', N'5237761032', N'libero@aol.couk')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (106, N'Ivory Bradley', N'5265617038', N'auctor.non@aol.ca')
INSERT [dbo].[Okur] ([OkurID], [OkurAdi], [OkurTelNo], [OkurEmail]) VALUES (107, N'Gail Hood', N'5227766273', N'dui.nec@outlook.net')
SET IDENTITY_INSERT [dbo].[Okur] OFF
GO
SET IDENTITY_INSERT [dbo].[Sehir] ON 

INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (1, N'Villavicencio', N'Ap #524-4691 Congue St.', N'Mexico')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (2, N'Mielec', N'Ap #376-8766 Ullamcorper. Av.', N'United Kingdom')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (3, N'North Waziristan', N'Ap #653-8078 Congue, St.', N'United States')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (4, N'Tiverton', N'Ap #490-214 Pellentesque Av.', N'China')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (5, N'Cleveland', N'959-8325 Ante. St.', N'United Kingdom')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (6, N'Leirvik', N'599-5931 Non St.', N'Germany')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (7, N'Chilliwack', N'9154 Sed St.', N'Chile')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (8, N'Bryne', N'Ap #898-6487 Enim St.', N'Spain')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (9, N'Bajaur Agency', N'970-9565 Sem Street', N'Pakistan')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (10, N'Alajuela', N'385-2158 Nibh Ave', N'Ireland')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (11, N'Ávila', N'Ap #526-1049 Nam St.', N'Sweden')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (12, N'Ceuta', N'Ap #873-5973 Eu Ave', N'South Korea')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (13, N'Mersin', N'Ap #369-7378 Adipiscing Street', N'Colombia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (14, N'La Roche-sur-Yon', N'408-1466 Scelerisque Av.', N'South Korea')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (15, N'Heusden', N'668-3528 Sem Rd.', N'India')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (16, N'Birecik', N'177-2367 Risus. St.', N'Australia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (17, N'Arauca', N'Ap #954-8667 Nisi Street', N'Austria')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (18, N'Cork', N'Ap #973-9492 Tincidunt Av.', N'Pakistan')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (19, N'Cartago', N'Ap #192-2340 Sodales Street', N'Germany')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (20, N'Colchester', N'729-7519 Iaculis Road', N'Austria')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (21, N'Quetta', N'P.O. Box 916, 2971 Nonummy Street', N'Russian Federation')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (22, N'Odda', N'934-4455 Feugiat Av.', N'Brazil')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (23, N'Glauchau', N'424-4475 Pellentesque Road', N'United States')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (24, N'Cherepovets', N'1024 Sed, Rd.', N'Australia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (25, N'Acapulco', N'Ap #818-2202 Sed St.', N'South Korea')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (26, N'Denderbelle', N'Ap #767-7368 Pharetra. Rd.', N'France')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (27, N'Greymouth', N'127-7037 Odio Rd.', N'New Zealand')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (28, N'Hilo', N'417-2104 Condimentum St.', N'Colombia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (29, N'Saint Louis', N'8276 Turpis. Road', N'Colombia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (30, N'Puerto Vallarta', N'549 Nec Street', N'South Korea')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (31, N'Volgograd', N'621-3716 Ut Av.', N'Peru')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (32, N'Reno', N'Ap #459-4122 Vestibulum Rd.', N'Norway')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (33, N'Shillong', N'488-8606 Urna St.', N'Spain')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (34, N'Kargopol', N'997-6200 Malesuada St.', N'Belgium')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (35, N'Florø', N'6797 Ac, St.', N'Germany')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (36, N'Macau', N'882-5897 Etiam Road', N'China')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (37, N'Brest', N'Ap #869-2681 Ac Road', N'Indonesia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (38, N'Koszalin', N'Ap #435-2484 Mi Ave', N'Costa Rica')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (39, N'Srinagar', N'9687 Molestie Av.', N'Peru')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (40, N'Trujillo', N'303-5756 Enim. Road', N'Mexico')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (41, N'Ludwigshafen', N'777-9671 Amet Av.', N'South Korea')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (42, N'Pocheon', N'2414 Suspendisse Rd.', N'United States')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (43, N'Huasco', N'Ap #352-2324 Semper, Road', N'Mexico')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (44, N'Nova Iguaçu', N'524-3578 Aliquet Road', N'Canada')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (45, N'Salihli', N'P.O. Box 937, 3382 Erat Ave', N'Brazil')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (46, N'Torun', N'P.O. Box 900, 7652 Mi St.', N'Colombia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (47, N'Siquirres', N'958-2742 Morbi Ave', N'Vietnam')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (48, N'Kedzierzyn-Kozle', N'Ap #597-423 In Ave', N'Peru')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (49, N'Kraków', N'Ap #216-8599 Magna Rd.', N'China')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (50, N'Troyes', N'8678 Urna. Ave', N'Nigeria')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (51, N'Henan', N'337-2136 Tortor Street', N'Russian Federation')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (52, N'Mielec', N'300-253 Elit Road', N'Canada')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (53, N'Coihaique', N'Ap #977-9009 Senectus Rd.', N'Netherlands')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (54, N'Finspång', N'P.O. Box 281, 2363 Suspendisse Rd.', N'United Kingdom')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (55, N'Bolano', N'277-6502 Lobortis St.', N'China')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (56, N'Rockhampton', N'Ap #842-6611 Sit St.', N'Colombia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (57, N'Hamme', N'661-9516 Aliquam Rd.', N'Chile')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (58, N'Sapele', N'984-772 Aliquam Avenue', N'Belgium')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (59, N'Lidingo', N'7127 Vitae, Rd.', N'United Kingdom')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (60, N'Inner Mongolia', N'709-5713 At Avenue', N'Poland')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (61, N'Chile Chico', N'P.O. Box 285, 5757 Torquent St.', N'Canada')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (62, N'Izel', N'Ap #719-7101 Dictum. Rd.', N'Ireland')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (63, N'Gerpinnes', N'P.O. Box 809, 2395 Ac St.', N'Belgium')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (64, N'Nelson', N'198-9133 Ipsum. Av.', N'Austria')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (65, N'Milnathort', N'607-2486 Integer Rd.', N'Brazil')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (66, N'La Plata', N'Ap #338-504 Tempor Ave', N'Poland')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (67, N'Augusta', N'Ap #886-5005 Mi St.', N'Chile')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (68, N'Waiuku', N'5935 Pretium St.', N'Spain')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (69, N'Elmshorn', N'Ap #334-9828 Nec, Ave', N'Chile')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (70, N'Nijmegen', N'2816 Integer Ave', N'France')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (71, N'Beijing', N'9890 Mauris St.', N'Costa Rica')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (72, N'Lerum', N'916-3505 Scelerisque Rd.', N'Turkey')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (73, N'San Francisco', N'2668 Sed Road', N'Colombia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (74, N'Metairie', N'877-3353 Enim Rd.', N'Italy')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (75, N'Mejillones', N'Ap #512-4034 Ac Av.', N'Pakistan')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (76, N'Skardu', N'6595 Vitae, St.', N'Colombia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (77, N'Móstoles', N'6926 Euismod Rd.', N'Italy')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (78, N'Huntsville', N'Ap #516-572 Erat Street', N'Vietnam')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (79, N'North Waziristan', N'P.O. Box 463, 6615 Sed Av.', N'Belgium')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (80, N'Bonavista', N'P.O. Box 558, 1086 Lorem, Avenue', N'Vietnam')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (81, N'Belford Roxo', N'P.O. Box 814, 4532 At St.', N'France')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (82, N'Lago Verde', N'Ap #995-4393 Ac Rd.', N'Canada')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (83, N'Täby', N'Ap #986-9215 Mauris Av.', N'France')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (84, N'Finspång', N'2302 Nulla. Rd.', N'Belgium')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (85, N'Kinross', N'1762 Semper Road', N'New Zealand')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (86, N'Liaoning', N'3283 Magna Road', N'Colombia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (87, N'Falun', N'Ap #506-8025 Sed Street', N'China')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (88, N'Khyber Agency', N'791-4006 Imperdiet, Rd.', N'Poland')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (89, N'Campitello di Fassa', N'Ap #194-8291 Semper St.', N'Sweden')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (90, N'Turgutlu', N'506-810 Pede Av.', N'Pakistan')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (91, N'General Escobedo', N'548-5312 Cursus Ave', N'Italy')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (92, N'Inner Mongolia', N'401-3247 Vulputate St.', N'Chile')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (93, N'Bharatpur', N'723-4961 Vitae Avenue', N'Costa Rica')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (94, N'Tilburg', N'Ap #540-149 Blandit Road', N'Nigeria')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (95, N'Sandefjord', N'P.O. Box 315, 7832 Rhoncus Rd.', N'South Korea')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (96, N'Ararat', N'751-155 Lacus. Road', N'Chile')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (97, N'Mirpur', N'959-8679 Nunc Rd.', N'Ireland')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (98, N'Versailles', N'Ap #313-4361 Tempus Road', N'United Kingdom')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (99, N'Sechura', N'Ap #218-4853 Duis Street', N'Belgium')
GO
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (100, N'Aurora', N'Ap #405-1860 Torquent Avenue', N'South Korea')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (101, N'Tauranga', N'971-4742 Elementum Av.', N'Indonesia')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (102, N'Bregenz', N'Ap #531-6480 Blandit Street', N'Ireland')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (103, N'Tranås', N'Ap #350-9161 Dui. Road', N'France')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (104, N'Chandigarh', N'7564 Urna St.', N'Spain')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (105, N'Tilly', N'324-8085 Dolor. St.', N'Poland')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (106, N'Volgograd', N'Ap #186-5171 Malesuada Street', N'United States')
INSERT [dbo].[Sehir] ([OkurID], [SehirAdi], [Adress], [UlkeAdi]) VALUES (107, N'Uppingham. Cottesmore', N'P.O. Box 459, 4305 Sit Rd.', N'Russian Federation')
SET IDENTITY_INSERT [dbo].[Sehir] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UC_Ktur]    Script Date: 18.01.2022 17:35:44 ******/
ALTER TABLE [dbo].[KitapTur] ADD  CONSTRAINT [UC_Ktur] UNIQUE NONCLUSTERED 
(
	[KitapTurID] ASC,
	[Tur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Odunc]  WITH CHECK ADD  CONSTRAINT [FK_Odunc_Kitap] FOREIGN KEY([KitapID])
REFERENCES [dbo].[Kitap] ([KitapID])
GO
ALTER TABLE [dbo].[Odunc] CHECK CONSTRAINT [FK_Odunc_Kitap]
GO
ALTER TABLE [dbo].[Odunc]  WITH CHECK ADD  CONSTRAINT [FK_Odunc_Okur] FOREIGN KEY([OkurID])
REFERENCES [dbo].[Okur] ([OkurID])
GO
ALTER TABLE [dbo].[Odunc] CHECK CONSTRAINT [FK_Odunc_Okur]
GO
ALTER TABLE [dbo].[Sehir]  WITH CHECK ADD  CONSTRAINT [FK_Sehir_Okur] FOREIGN KEY([OkurID])
REFERENCES [dbo].[Okur] ([OkurID])
GO
ALTER TABLE [dbo].[Sehir] CHECK CONSTRAINT [FK_Sehir_Okur]
GO
/****** Object:  StoredProcedure [dbo].[oduncal]    Script Date: 18.01.2022 17:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[oduncal] @okId Int,@kitID nvarchar(6)
as
declare @KitSay int
Set @KitSay = (Select KitapSayfasi from Kitap Where KitapID=@kitID)
INSERT INTO Odunc
Values
(@okId,@kitID,dbo.GunSayisi(@KitSay),getdate(),'Okurda')
GO
/****** Object:  StoredProcedure [dbo].[RandomOduncal]    Script Date: 18.01.2022 17:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[RandomOduncal] @okId Int,@kitID nvarchar(6)
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
/****** Object:  StoredProcedure [dbo].[teslimet]    Script Date: 18.01.2022 17:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[teslimet] @okId Int,@kitID nvarchar(6)
as
Update Odunc
Set Durum = 'Teslimli' , TeslimTarihi = Getdate() where OkurID=@okId AND KitapID=@kitID
GO
/****** Object:  StoredProcedure [dbo].[turekle]    Script Date: 18.01.2022 17:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[turekle] @kitTurId Int,@Tur nvarchar(15)
as
INSERT INTO KitapTur VALUES(@kitTurId,@Tur)
GO
USE [master]
GO
ALTER DATABASE [Library] SET  READ_WRITE 
GO
