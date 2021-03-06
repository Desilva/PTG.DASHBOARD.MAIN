USE [master]
GO
/****** Object:  Database [PTG.MAIN]    Script Date: 14-Oct-17 12:32:30 PM ******/
CREATE DATABASE [PTG.MAIN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PTG.MAIN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PTG.MAIN.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PTG.MAIN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PTG.MAIN_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PTG.MAIN] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PTG.MAIN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PTG.MAIN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PTG.MAIN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PTG.MAIN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PTG.MAIN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PTG.MAIN] SET ARITHABORT OFF 
GO
ALTER DATABASE [PTG.MAIN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PTG.MAIN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PTG.MAIN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PTG.MAIN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PTG.MAIN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PTG.MAIN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PTG.MAIN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PTG.MAIN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PTG.MAIN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PTG.MAIN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PTG.MAIN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PTG.MAIN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PTG.MAIN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PTG.MAIN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PTG.MAIN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PTG.MAIN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PTG.MAIN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PTG.MAIN] SET RECOVERY FULL 
GO
ALTER DATABASE [PTG.MAIN] SET  MULTI_USER 
GO
ALTER DATABASE [PTG.MAIN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PTG.MAIN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PTG.MAIN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PTG.MAIN] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PTG.MAIN] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PTG.MAIN', N'ON'
GO
USE [PTG.MAIN]
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actions](
	[Id] [uniqueidentifier] NOT NULL,
	[ActionName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_Actions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ActionsInModules]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActionsInModules](
	[ActionId] [uniqueidentifier] NOT NULL,
	[ModuleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ActionsInModules] PRIMARY KEY CLUSTERED 
(
	[ActionId] ASC,
	[ModuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ActionsInModulesChosen]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActionsInModulesChosen](
	[ModuleInRoleId] [uniqueidentifier] NOT NULL,
	[ActionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ActionsInModulesChosen] PRIMARY KEY CLUSTERED 
(
	[ModuleInRoleId] ASC,
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Applications]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[ApplicationName] [nvarchar](235) NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[log]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[timestamp] [datetime] NOT NULL,
	[application] [nvarchar](max) NULL,
	[ip] [nvarchar](max) NULL,
	[user] [nvarchar](max) NULL,
	[action] [nvarchar](max) NULL,
	[data] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Memberships]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Memberships](
	[UserId] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowsStart] [datetime] NOT NULL,
	[Comment] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Modules]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modules](
	[Id] [uniqueidentifier] NOT NULL,
	[ModuleName] [nvarchar](256) NOT NULL,
	[ParentModule] [nvarchar](50) NULL,
 CONSTRAINT [PK_Modules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ModulesInRoles]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModulesInRoles](
	[Id] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ModuleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ModulesInRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Risk]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Risk](
	[RiskId] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NOT NULL,
	[ProcessBusiness] [varchar](255) NULL,
	[RiskCategory] [varchar](255) NULL,
	[RiskEvent] [varchar](max) NULL,
	[RiskAgent] [varchar](max) NULL,
	[KRI] [varchar](max) NULL,
	[Controll] [varchar](max) NULL,
	[QualitatifImpact] [varchar](max) NULL,
	[RiskClasification] [varchar](20) NULL,
	[QualitatifQuantitatifRisk] [varchar](50) NULL,
	[RiskNumber] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL CONSTRAINT [DF_Risk_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Risk] PRIMARY KEY CLUSTERED 
(
	[RiskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RiskDocument]    Script Date: 14-Oct-17 12:32:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskDocument](
	[DocumentId] [int] IDENTITY(1,1) NOT NULL,
	[FilePath] [varchar](255) NOT NULL,
	[Notes] [varchar](255) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_RiskDocument] PRIMARY KEY CLUSTERED 
(
	[DocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RiskImpact]    Script Date: 14-Oct-17 12:32:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskImpact](
	[ImpactId] [int] IDENTITY(1,1) NOT NULL,
	[RiskId] [int] NOT NULL,
	[Type] [varchar](100) NOT NULL,
	[QuantitatifImpact] [float] NULL,
	[Probability] [int] NULL,
	[Impact] [int] NULL,
	[RPN] [int] NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL CONSTRAINT [DF_RiskImpact_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_RiskImpact] PRIMARY KEY CLUSTERED 
(
	[ImpactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RiskMitigation]    Script Date: 14-Oct-17 12:32:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskMitigation](
	[MitigationId] [int] IDENTITY(1,1) NOT NULL,
	[RiskId] [int] NOT NULL,
	[MitigationPlan] [varchar](max) NOT NULL,
	[Plan] [int] NULL,
	[Actual] [int] NULL,
	[Evidence] [varchar](255) NULL,
	[notes] [varchar](max) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL CONSTRAINT [DF_RiskMitigation_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_RiskMitigation] PRIMARY KEY CLUSTERED 
(
	[MitigationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 14-Oct-17 12:32:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 14-Oct-17 12:32:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UsersInRoles]    Script Date: 14-Oct-17 12:32:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Applications] ([ApplicationId], [ApplicationName], [Description]) VALUES (N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'PTG.MAIN', NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'0047d7f4-27f4-4555-b57a-330603eaa4c1', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'+BPL8H08iJzTM5pL+1d1SKhCq3h4EvQM9yOrHCrrKLY=', 1, N'el2Nota2TfR9Z1FO2WIFGA==', N'-', NULL, NULL, 1, 0, CAST(N'2017-09-06 03:40:48.943' AS DateTime), CAST(N'2017-10-14 05:31:25.333' AS DateTime), CAST(N'2017-09-06 03:40:48.943' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'156a2cd8-1b66-46be-8536-758efd2d96d8', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'BbEJ5XXnCaVuJ0Lf03UTpxiK63KEKajQqV7IcNhuILA=', 1, N'6BFYNc+Lq31mISSOdZIv5w==', N'-', NULL, NULL, 1, 0, CAST(N'2017-09-05 15:43:09.243' AS DateTime), CAST(N'2017-09-05 15:47:12.390' AS DateTime), CAST(N'2017-09-05 15:43:09.243' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Risk] ON 

INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1041, 2017, N'Pendapatan Operasi', N'Liquiduty & Finance Intelligence', N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Potensi risiko keterlambatan penerimaan dana atas piutang dagang</span>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'YELLOW', N'QUANTITATIVE', N'PTG-2017-001', N'admin', CAST(N'2017-09-18 18:12:59.687' AS DateTime), N'admin', CAST(N'2017-09-18 18:12:59.687' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1042, 2017, N'Transportasi Gas', N'Liquiduty & Finance Intelligence', N'Potensi risiko tidak tercapainya target volume pengaliran gas', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'YELLOW', N'QUALITATIVE', N'PTG-2017-002', N'admin', CAST(N'2017-09-18 18:17:48.383' AS DateTime), N'admin', CAST(N'2017-09-18 18:17:48.383' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1043, 2017, N'Gas Processing', N'Liquidity & Finance Intelligence', N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Potensi risiko tidak tercapainya target volume produksi LPG</span>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'YELLOW', N'QUANTITATIVE', N'PTG-2017-003', N'admin', CAST(N'2017-09-18 18:20:21.000' AS DateTime), N'admin', CAST(N'2017-09-18 18:21:56.180' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1044, 2017, N'Penjualan Gas', N'Gas Sales Section', N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Potensi risiko tidak tercapainya target volume niaga gas</span>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'YELLOW', N'QUANTITATIVE', N'PTG-2017-004', N'admin', CAST(N'2017-09-18 18:23:07.000' AS DateTime), N'admin', CAST(N'2017-09-18 18:23:15.663' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1045, 2017, N'Regasifikasi', N'Liquidity & Finance Intelligence', N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Potensi risiko tidak tercapainya target volume penyerapan gas hasil regasifikasi Perta Arun Gas</span>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'GREEN', N'QUALITATIVE', N' PTG-2017-005', N'admin', CAST(N'2017-09-18 18:25:37.000' AS DateTime), N'admin', CAST(N'2017-09-18 18:25:47.137' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1046, 2016, N'Pendapatan Operasi', N'Liquidity & Finance Intelligence', N'Potensi pengeluaran tambahan pada bagian operasional gas', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'YELLOW', N'QUALITATIVE', N'PTG-2016-001', N'admin', CAST(N'2017-09-18 18:31:07.880' AS DateTime), N'admin', CAST(N'2017-09-18 18:31:07.880' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Risk] OFF
SET IDENTITY_INSERT [dbo].[RiskImpact] ON 

INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (10, 1041, N'INHERENT', 12573, 5, 5, 25, N'admin', CAST(N'2017-09-18 18:13:27.513' AS DateTime), N'admin', CAST(N'2017-09-18 18:13:27.513' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (11, 1041, N'RESIDUAL', 12573, 2, 1, 2, N'admin', CAST(N'2017-09-18 18:13:27.540' AS DateTime), N'admin', CAST(N'2017-09-18 18:13:27.540' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (12, 1042, N'INHERENT', 23723, 2, 1, 15, N'admin', CAST(N'2017-09-18 18:19:20.267' AS DateTime), N'admin', CAST(N'2017-09-18 18:19:20.267' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (13, 1042, N'RESIDUAL', 5438, 3, 3, 14, N'admin', CAST(N'2017-09-18 18:19:20.323' AS DateTime), N'admin', CAST(N'2017-09-18 18:19:20.323' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (14, 1043, N'INHERENT', 5345, 4, 1, 43, N'admin', CAST(N'2017-09-18 18:20:40.157' AS DateTime), N'admin', CAST(N'2017-09-18 18:20:40.157' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (15, 1043, N'RESIDUAL', 4275, 3, 3, 40, N'admin', CAST(N'2017-09-18 18:20:40.173' AS DateTime), N'admin', CAST(N'2017-09-18 18:20:40.173' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (16, 1044, N'INHERENT', 35536, 4, 3, 21, N'admin', CAST(N'2017-09-18 18:23:38.853' AS DateTime), N'admin', CAST(N'2017-09-18 18:23:38.853' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (17, 1044, N'RESIDUAL', 34854, 3, 3, 23, N'admin', CAST(N'2017-09-18 18:23:38.870' AS DateTime), N'admin', CAST(N'2017-09-18 18:23:38.870' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (18, 1045, N'INHERENT', 678, 1, 3, 511, N'admin', CAST(N'2017-09-18 18:26:13.183' AS DateTime), N'admin', CAST(N'2017-09-18 18:26:13.183' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (19, 1045, N'RESIDUAL', 768, 2, 3, 515, N'admin', CAST(N'2017-09-18 18:26:13.203' AS DateTime), N'admin', CAST(N'2017-09-18 18:26:13.203' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (20, 1046, N'INHERENT', 4324, 3, 2, 34, N'admin', CAST(N'2017-09-18 18:31:21.983' AS DateTime), N'admin', CAST(N'2017-09-18 18:31:21.983' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (21, 1046, N'RESIDUAL', 1231, 2, 4, 32, N'admin', CAST(N'2017-09-18 18:31:22.000' AS DateTime), N'admin', CAST(N'2017-09-18 18:31:22.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[RiskImpact] OFF
SET IDENTITY_INSERT [dbo].[RiskMitigation] ON 

INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (30, 1041, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Pertagas telah mengirimkan surat somasi ke ME pada bulan September 2016, setelah somasi dilayangkan dan direspon oleh pihak ME berupa ketidaksanggupan pelunasan piutang sesuai somasi, maka akan dilanjutkan dengan mediasi.</span>', 7, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:13:46.697' AS DateTime), N'admin', CAST(N'2017-09-18 18:13:46.697' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (31, 1041, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Pertagas akan melakukan somasi kepada Odira untuk melakukan pelunasan piutang.</span>', 4, 5, NULL, NULL, N'admin', CAST(N'2017-09-18 18:14:06.613' AS DateTime), N'admin', CAST(N'2017-09-18 18:14:06.613' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (32, 1041, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Mencari peluang melakukan pelunasan piutang ME &amp; Odira melalui offseting di Pertamina Group.</span>', 2, 2, NULL, NULL, N'admin', CAST(N'2017-09-18 18:14:16.813' AS DateTime), N'admin', CAST(N'2017-09-18 18:14:16.813' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (33, 1042, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan komunikasi dan koordinasi secara intensif dengan Pertagas Niaga untuk meningkatkan penyerapan pasar eksisting &amp; pasar baru dan dengan KKKS untuk memastikan suplai gas lancar</span>', 3, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:18:15.313' AS DateTime), N'admin', CAST(N'2017-09-18 18:18:15.313' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (34, 1042, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan percepatan proses penyelesaian proyek:</span><ul style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Konstruksi pada proyek Pipa Semare</li><li style="box-sizing:border-box;">Konstruksi pada ruas Gresik-Semarang</li><li style="box-sizing:border-box;">Konstruksi pada ruas Grissik-Pusri</li><li style="box-sizing:border-box;">Konstruksi pada ruas PKG Looping</li></ul>', 6, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:18:26.103' AS DateTime), N'admin', CAST(N'2017-09-18 18:18:26.103' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (35, 1042, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan kegiatan maintenance untuk kehandalan pipa:</span><br style="box-sizing:border-box;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;" /><ul style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Perbaikan Erosi ROW Jalur Pipa Gas Distrik Bitung KP 157 (WJA)</li><li style="box-sizing:border-box;">Perbaikan erosi,saluran air dan jembatan di ruas wilayah Cilamaya KP 03.9,KP 005,KP 029.9,KP 00.9,KP 002.4, Erosi di KP 037.5 (WJA)</li><li style="box-sizing:border-box;">Pemasangan Fasilitas Corrosion Monitoring System pada Pipa Penyalur di Wilayah PT Pertamina Gas SSA</li><li style="box-sizing:border-box;">In Line Inspection dengan Intelligent Pig untuk Pipa 20&rdquo; Betung - Benuang, 20&rdquo; Benuang &ndash; Prabumulih Barat, 20&rdquo; Simpang Y &ndash; PUSRI(Looping), 12&rdquo; Limau Timur &ndash; Prabumulih Barat, 12&rdquo; Prabumulih Barat - Cambai</li></ul>', 4, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:18:35.173' AS DateTime), N'admin', CAST(N'2017-09-18 18:18:35.173' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (36, 1042, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Membuat kajian skema bisnis terintegrasi dari hulu ke hilir atas penurunan toll fee untuk meningkatkatkan volume penjualan gas di Sumatera Bagian Utara</span>', 1, 2, NULL, NULL, N'admin', CAST(N'2017-09-18 18:18:46.083' AS DateTime), N'admin', CAST(N'2017-09-18 18:18:46.083' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (37, 1043, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan negosiasi kenaikan feed gas dengan kompensasi penurunan tarif condensat handling fee</span>', 4, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:20:52.937' AS DateTime), N'admin', CAST(N'2017-09-18 18:20:52.937' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (38, 1043, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan koordinasi dengan PT Pertamina EP untuk mencari sumber gas baru yang mengandung C3 dan C4 tinggi (misalkan Limau Timur/Paku Gajah/Pagar Dewa)</span>', 9, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:21:03.247' AS DateTime), N'admin', CAST(N'2017-09-18 18:21:03.247' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (39, 1043, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan koordinasi dengan PT Pertamina EP terkait optimalisasi operasi Dehydration Unit (DHU) di Musi Barat secara intensif</span>', 10, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:21:11.297' AS DateTime), N'admin', CAST(N'2017-09-18 18:21:11.297' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (40, 1043, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan koordinasi dengan PT Pertamina EP terkait kondisi upstream yang dapat menurunkan supply gas.</span>', 7, 6, NULL, NULL, N'admin', CAST(N'2017-09-18 18:21:22.393' AS DateTime), N'admin', CAST(N'2017-09-18 18:21:22.393' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (41, 1043, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan koordinasi dengan PT Pertamina EP terkait pengadaan tambahan slug catcher baru di Prabumulih Barat</span>', 3, 3, NULL, NULL, N'admin', CAST(N'2017-09-18 18:21:33.387' AS DateTime), N'admin', CAST(N'2017-09-18 18:21:33.387' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (42, 1044, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Koordinasi dengan konsumen eksisting tekait fluktuasi volume penyerapan dan tindak lanjutnya.</span>', 5, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:23:47.617' AS DateTime), N'admin', CAST(N'2017-09-18 18:23:47.617' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (43, 1044, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan inspeksi jaringan pipa dan transportasi darat secara rutin .</span>', 1, 3, NULL, NULL, N'admin', CAST(N'2017-09-18 18:23:55.867' AS DateTime), N'admin', CAST(N'2017-09-18 18:23:55.867' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (44, 1044, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Koordinasi secara intensif terkait alokasi LNG dan gas pipa dengan fungsi LNG dan fungsi Gas Sourcing Dit. GEBT serta melalui forum CIG.</span>', 3, 3, NULL, NULL, N'admin', CAST(N'2017-09-18 18:24:04.397' AS DateTime), N'admin', CAST(N'2017-09-18 18:24:04.397' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (45, 1044, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Mempercepat realisasi PJBG baru dengan:</span><ul style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Monitoring progress perikatan komersial dengan calon konsumen baru.</li><li style="box-sizing:border-box;">Menggunakan portofolio pasokan untuk mencapai harga yang kompetitif (di wilayah yang memiliki lebih dari 2 sumber pasokan) jika dimungkinkan.</li><li style="box-sizing:border-box;">Mempersiapkan konsumen baru dengan volume demand yang lebih besar dari target volume RKAP.</li></ul>', 5, 4, NULL, NULL, N'admin', CAST(N'2017-09-18 18:24:14.220' AS DateTime), N'admin', CAST(N'2017-09-18 18:24:14.220' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (46, 1044, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Koordinasi intensif dengan konsumen baru terkait kesiapan mereka menyerap gas sesuai target waktu yang disepakati.</span>', 3, 3, NULL, NULL, N'admin', CAST(N'2017-09-18 18:24:24.363' AS DateTime), N'admin', CAST(N'2017-09-18 18:24:24.363' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (47, 1044, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Koordinasi dengan fungsi terkait di Pertagas beserta afiliasi dan konsumen terkait pembangunan infrastruktur.</span>', 6, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:24:32.817' AS DateTime), N'admin', CAST(N'2017-09-18 18:24:32.817' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (48, 1044, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Koordinasi dengan Ditjen Migas dan Pelaksanana pembangunan infrastruktur jargas dan fungsi City Gas Dit. GEBT.</span>', 8, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:24:43.327' AS DateTime), N'admin', CAST(N'2017-09-18 18:24:43.327' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (49, 1044, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Koordinasi dengan fungsi Business Development Pertagas terkait peningkatan kapasitas penyaluran plant</span>', 8, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:24:52.370' AS DateTime), N'admin', CAST(N'2017-09-18 18:24:52.370' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (50, 1045, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Memasukkan klausul Use or Pay 90% (94.5 MMSCFD) dalam perjanjian (saat ini masih Kesepakatan Bersama) kepada para konsumen</span>', 4, 4, NULL, NULL, N'admin', CAST(N'2017-09-18 18:26:22.600' AS DateTime), N'admin', CAST(N'2017-09-18 18:26:22.600' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (51, 1045, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan koordinasi dan komunikasi dengan PLN terkait dengan unscheduled shutdown</span>', 5, 4, NULL, N'Sudah dilaksanakan lebih cepat dari tanggal terjadwal', N'admin', CAST(N'2017-09-18 18:26:47.503' AS DateTime), N'admin', CAST(N'2017-09-18 18:26:47.503' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (52, 1045, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan Planned Maintenance sesuai dengan rekomendasi pabrikan</span>', 9, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:27:18.777' AS DateTime), N'admin', CAST(N'2017-09-18 18:27:18.777' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (53, 1045, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Menyusun kajian pola serapan bulanan konsumen (PLN &amp; PTGN)</span>', 6, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:27:27.733' AS DateTime), N'admin', CAST(N'2017-09-18 18:27:27.733' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (54, 1045, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Membuat jalur alternatif LNG Filling Station (temporary) untuk meningkatkan serapan volume LNG konsumen</span>', 5, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:27:40.197' AS DateTime), N'admin', CAST(N'2017-09-18 18:27:40.197' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (55, 1046, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Pertagas akan melakukan somasi kepada Odira untuk melakukan pelunasan piutang.</span>', 1, 1, NULL, NULL, N'admin', CAST(N'2017-09-18 18:31:38.450' AS DateTime), N'admin', CAST(N'2017-09-18 18:31:38.450' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (56, 1046, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Pertagas telah mengirimkan surat somasi ke ME pada bulan September 2016, setelah somasi dilayangkan dan direspon oleh pihak ME berupa ketidaksanggupan pelunasan piutang sesuai somasi, maka akan dilanjutkan dengan mediasi.</span>', 3, 4, NULL, N'Mitigasi selesai', N'admin', CAST(N'2017-09-18 18:31:57.550' AS DateTime), N'admin', CAST(N'2017-09-18 18:31:57.550' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[RiskMitigation] OFF
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'0047d7f4-27f4-4555-b57a-330603eaa4c1', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'admin', 0, CAST(N'2017-10-14 05:31:25.333' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'156a2cd8-1b66-46be-8536-758efd2d96d8', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'yosef', 0, CAST(N'2017-09-05 15:47:12.390' AS DateTime))
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_UserName]    Script Date: 14-Oct-17 12:32:31 PM ******/
CREATE NONCLUSTERED INDEX [IDX_UserName] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActionsInModules]  WITH CHECK ADD  CONSTRAINT [FK_ActionsInModules_Actions] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActionsInModules] CHECK CONSTRAINT [FK_ActionsInModules_Actions]
GO
ALTER TABLE [dbo].[ActionsInModules]  WITH CHECK ADD  CONSTRAINT [FK_ActionsInModules_Modules] FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Modules] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActionsInModules] CHECK CONSTRAINT [FK_ActionsInModules_Modules]
GO
ALTER TABLE [dbo].[ActionsInModulesChosen]  WITH CHECK ADD  CONSTRAINT [FK_ActionsInModulesChosen_Actions] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActionsInModulesChosen] CHECK CONSTRAINT [FK_ActionsInModulesChosen_Actions]
GO
ALTER TABLE [dbo].[ActionsInModulesChosen]  WITH CHECK ADD  CONSTRAINT [FK_ActionsInModulesChosen_ModulesInRoles] FOREIGN KEY([ModuleInRoleId])
REFERENCES [dbo].[ModulesInRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActionsInModulesChosen] CHECK CONSTRAINT [FK_ActionsInModulesChosen_ModulesInRoles]
GO
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipEntity_Application] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipEntity_Application]
GO
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipEntity_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipEntity_User]
GO
ALTER TABLE [dbo].[ModulesInRoles]  WITH CHECK ADD  CONSTRAINT [FK_ModulesInRoles_Modules] FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Modules] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ModulesInRoles] CHECK CONSTRAINT [FK_ModulesInRoles_Modules]
GO
ALTER TABLE [dbo].[ModulesInRoles]  WITH CHECK ADD  CONSTRAINT [FK_ModulesInRoles_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ModulesInRoles] CHECK CONSTRAINT [FK_ModulesInRoles_Roles]
GO
ALTER TABLE [dbo].[RiskImpact]  WITH CHECK ADD  CONSTRAINT [FK_RiskImpact_Risk] FOREIGN KEY([RiskId])
REFERENCES [dbo].[Risk] ([RiskId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RiskImpact] CHECK CONSTRAINT [FK_RiskImpact_Risk]
GO
ALTER TABLE [dbo].[RiskMitigation]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigation_Risk] FOREIGN KEY([RiskId])
REFERENCES [dbo].[Risk] ([RiskId])
GO
ALTER TABLE [dbo].[RiskMitigation] CHECK CONSTRAINT [FK_RiskMitigation_Risk]
GO
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [RoleEntity_Application] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [RoleEntity_Application]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [User_Application] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [User_Application]
GO
ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRole_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRole_Role]
GO
ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRole_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRole_User]
GO
USE [master]
GO
ALTER DATABASE [PTG.MAIN] SET  READ_WRITE 
GO
