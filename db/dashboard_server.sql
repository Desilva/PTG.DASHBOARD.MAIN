USE [master]
GO
/****** Object:  Database [DB_DSHB_RISK]    Script Date: 1/16/2018 10:10:59 AM ******/
CREATE DATABASE [DB_DSHB_RISK]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_DSHB_RISK', FILENAME = N'E:\Database\DB_DSHB_RISK.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DB_DSHB_RISK_log', FILENAME = N'E:\Log\DB_DSHB_RISK_log.ldf' , SIZE = 6144KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DB_DSHB_RISK] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_DSHB_RISK].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_DSHB_RISK] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_DSHB_RISK] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_DSHB_RISK] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB_DSHB_RISK] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_DSHB_RISK] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET RECOVERY FULL 
GO
ALTER DATABASE [DB_DSHB_RISK] SET  MULTI_USER 
GO
ALTER DATABASE [DB_DSHB_RISK] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_DSHB_RISK] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_DSHB_RISK] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_DSHB_RISK] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DB_DSHB_RISK', N'ON'
GO
USE [DB_DSHB_RISK]
GO
/****** Object:  User [sa_dshb]    Script Date: 1/16/2018 10:11:01 AM ******/
CREATE USER [sa_dshb] FOR LOGIN [sa_dshb] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PERTAMINAGAS\nms-acc-ptg]    Script Date: 1/16/2018 10:11:01 AM ******/
CREATE USER [PERTAMINAGAS\nms-acc-ptg] FOR LOGIN [PERTAMINAGAS\nms-acc-ptg] WITH DEFAULT_SCHEMA=[PERTAMINAGAS\nms-acc-ptg]
GO
ALTER ROLE [db_owner] ADD MEMBER [sa_dshb]
GO
/****** Object:  Schema [PERTAMINAGAS\nms-acc-ptg]    Script Date: 1/16/2018 10:11:02 AM ******/
CREATE SCHEMA [PERTAMINAGAS\nms-acc-ptg]
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[ActionsInModules]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[ActionsInModulesChosen]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[Applications]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[log]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[Memberships]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[Modules]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[ModulesInRoles]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[Profiles]    Script Date: 1/16/2018 10:11:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profiles](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [nvarchar](max) NOT NULL,
	[PropertyValueStrings] [nvarchar](max) NOT NULL,
	[PropertyValueBinary] [varbinary](max) NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Profiles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Risk]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[RiskDocument]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[RiskImpact]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[RiskMitigation]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 1/16/2018 10:11:02 AM ******/
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
/****** Object:  Table [dbo].[UsersInRoles]    Script Date: 1/16/2018 10:11:02 AM ******/
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
INSERT [dbo].[Actions] ([Id], [ActionName]) VALUES (N'f5157893-420f-421c-86a5-035bab7e8c24', N'Update')
INSERT [dbo].[Actions] ([Id], [ActionName]) VALUES (N'33c4f7c9-eb92-4e79-85d0-51f41c3d9cb9', N'View')
INSERT [dbo].[Actions] ([Id], [ActionName]) VALUES (N'fbf816b0-dc4b-4461-a17a-727d75c8892a', N'Delete')
INSERT [dbo].[Actions] ([Id], [ActionName]) VALUES (N'4ed54466-54f9-4003-9edc-905a78296c8f', N'Create')
INSERT [dbo].[ActionsInModules] ([ActionId], [ModuleId]) VALUES (N'33c4f7c9-eb92-4e79-85d0-51f41c3d9cb9', N'c91435c6-121d-4e75-b955-af4ebe71d679')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'64b31528-f298-4682-b279-266ddfa4252e', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'0db40530-3e25-45f8-a473-32b58648efa4', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'e360bd61-fe65-4bb3-b0ed-40072cda3e11', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'352638db-7f3f-4b1b-aa24-4a87085718cc', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'b122e343-cf1f-4be9-ab4b-4d2b33367f5d', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'be9dc26a-598e-40a5-8da8-5e5c515c1a89', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'a9eea255-5519-4c4d-9318-62c06e2fa805', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'7eb8944d-3ca7-472f-bbb2-6b9dfb02dcc7', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'74841ca7-ce1e-4455-9b2b-7023e612eeb9', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'3495c233-f7e6-42ce-b42d-7848486fccc5', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'50df1562-79ad-404e-9c29-99df183e0e6c', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'c1ba4b80-2b6f-4c52-adb5-a18907bdbf59', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'e9904927-85bb-4944-8294-addad1079555', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'2c3ee86f-ebc4-4cd4-869d-aeaf94ef8a21', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'6716d2ce-aff6-4d39-a792-bbbfea5d2e9b', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'38fef1df-e3da-4b12-bcf3-ce692ccc6740', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'25ffe728-5005-4aeb-b971-d06e256b5f5b', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'da3e3903-5900-4d83-9c51-d200f9bb65dd', N'33c4f7c9-eb92-4e79-85d0-51f41c3d9cb9')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'f05b435d-4193-4009-baff-d3c96b9e27ee', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'409ee262-e64e-440e-a494-df170123725b', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'cc07387d-9b15-4ab8-91bc-ff14bdfdcf9e', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'f78c716b-2572-4034-8e4a-ff6b0959190a', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[ActionsInModulesChosen] ([ModuleInRoleId], [ActionId]) VALUES (N'8324c89c-a8b9-4e1e-967d-ffffefa99355', N'4ed54466-54f9-4003-9edc-905a78296c8f')
INSERT [dbo].[Applications] ([ApplicationId], [ApplicationName], [Description]) VALUES (N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'PTG.MAIN', NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'451a8a97-a75d-4916-b4f2-06ce3be8af41', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'qQDcYU3X9Tyd8IaiTwGfwNYK/R85O8GT2Secn643P4g=', 1, N'YFSAJQ6mCt3mSQSVe1qEcw==', N'rahadiang.kusumo@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-01 05:06:41.183' AS DateTime), CAST(N'2017-11-01 05:06:41.183' AS DateTime), CAST(N'2017-11-01 05:06:41.183' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'2be80de0-18e5-42b7-b6ac-081d2dccef96', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'zNJqeHLJrg05OxHqLfazDW/bEax+8YUFqg6FDGhdk54=', 1, N'zKXL2oQbE3J9SvhcULVHKA==', N'ivan.md@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-09 02:45:40.447' AS DateTime), CAST(N'2017-11-09 02:45:40.447' AS DateTime), CAST(N'2017-11-09 02:45:40.447' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'09af6c22-b787-4bd2-8580-20a3b5c6db83', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'A0vEM4WTsjcb0j6OVAki7U0HX3Bd6TNReoJgYCgspMk=', 1, N'RCs2Ymn5700IMYuXUogUYw==', N'mk.martha.fiski@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-02 07:02:05.187' AS DateTime), CAST(N'2017-11-02 07:02:05.187' AS DateTime), CAST(N'2017-11-02 07:02:05.187' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'cb4df1fb-ce3e-4305-bbad-29f39c8e5ed6', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'W9TyJoOa7nUat1SLRdIRfE61LubzCJjn3ibb4JNc/gY=', 1, N'mQCffEJ2FtJbnQDkGADw4A==', N'mk.atus.gestyanto@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-12-21 02:06:32.237' AS DateTime), CAST(N'2017-12-29 02:16:01.273' AS DateTime), CAST(N'2017-12-21 02:06:32.237' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'2ad7e935-4af0-482c-a710-2a633d5a349b', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'tK0hQMw1C8VIGtSWr00ArQGVkUexqa9SBaJwiSGHyqY=', 1, N'/1nkQbzbEDaOQqUIhYWfsw==', N'mk.oki.handoko@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-03 02:12:03.433' AS DateTime), CAST(N'2017-11-03 02:12:03.433' AS DateTime), CAST(N'2017-11-03 02:12:03.433' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'377095d0-9ce5-4932-b5c1-2e9905dabfcd', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'PaFQ4z0TZYSxIhqCv7bCOfUi8SyuzBEY2LjBLrtXFms=', 1, N'K1rR72nm6I0mlQbqXyAZ9Q==', N'izzul.naisan@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-10-31 02:36:42.687' AS DateTime), CAST(N'2017-11-07 17:47:38.583' AS DateTime), CAST(N'2017-10-31 02:36:42.687' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'01b9718f-b1ef-40e6-88d7-32d110d4ade4', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'AvXQiGcTWMqNbHBSzXn0PGpKJOEcS2oR6tSzSIdWp7c=', 1, N'aw/QD7HMSW5rukQlRM3wjw==', N'Syaftiria@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-02 06:59:09.477' AS DateTime), CAST(N'2017-11-14 03:39:52.237' AS DateTime), CAST(N'2017-11-02 06:59:09.477' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'9b7610bb-adb4-4573-9d9d-3bfa909448c8', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'NA8vEX7UoQcQfrKAQDRgXMKrYCKPXe8BnCIN8ebBoBo=', 1, N'49J0kuLIKTtwh/mIi75U9w==', N'rahmat.nasution@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-02 07:00:28.667' AS DateTime), CAST(N'2017-11-02 07:00:28.667' AS DateTime), CAST(N'2017-11-02 07:00:28.667' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'd72c2853-1f9f-415d-9531-3ccd96ec3814', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'a5uk6b79drzj6C2etIRs2KvF6V0ExfM1zjyIOBA7RxE=', 1, N'I8/OESSGYhaNasmUsQFXjw==', N'marindra@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-01 04:31:49.160' AS DateTime), CAST(N'2018-01-16 03:04:12.277' AS DateTime), CAST(N'2017-11-01 04:31:49.160' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'5f7043b2-ad31-47e8-98da-4424b3fd4986', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'5ZtROZvD0Kxm6XSLENJDB2L6q77DwavEn3SKIhc2mK8=', 1, N'rKD6Y12Y5qMHj52FVNJb+Q==', N'erna.kusumadewi@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-28 07:35:34.550' AS DateTime), CAST(N'2017-11-28 07:35:34.550' AS DateTime), CAST(N'2017-11-28 07:35:34.550' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'21aa5118-4106-4b58-8132-4ccfd0858ce5', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'J8rfFo84KMTOm4J224mkXIN8qTwtjfc4WYwaji4yFag=', 1, N'/RNUzK924vZYbBaSvHdseA==', N'rahim.hanifah@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-02 06:59:08.637' AS DateTime), CAST(N'2017-11-02 06:59:08.637' AS DateTime), CAST(N'2017-11-02 06:59:08.637' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'3d7b6e65-498e-49f7-8e30-4ff3318a2e91', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'cY4zZyKiatP6G1dOKTayJqcSZnILos8vsWtQrCMNEgo=', 1, N'eEvIEqYMlL3X0bDNLrvpOg==', N'rully.hidayat@pertamina.com', NULL, NULL, 1, 0, CAST(N'2018-01-12 03:17:44.503' AS DateTime), CAST(N'2018-01-12 03:17:44.503' AS DateTime), CAST(N'2018-01-12 03:17:44.503' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'e0840d9b-f0d7-4472-b560-53fa572259cd', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'xkh24RDrtSqj0jh7slme3Ml6lmvqRybzEE1AFJs1O40=', 1, N'FyxcUWHW08/f+NE+9cQmvA==', N'sri.harlinda@pertamina.com', NULL, NULL, 1, 0, CAST(N'2018-01-09 07:43:41.180' AS DateTime), CAST(N'2018-01-09 07:43:41.180' AS DateTime), CAST(N'2018-01-09 07:43:41.180' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'86d77348-a917-4efd-b038-5515bf3b264e', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'r2bTk8MOza0pVE1BteGKOjVnqkMiIjDJDYfDEXEIkqg=', 1, N'1n+lklRPK4xhbfmi0OAyhA==', N'raditya.primayudha@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-02 07:19:28.037' AS DateTime), CAST(N'2017-11-02 07:19:28.037' AS DateTime), CAST(N'2017-11-02 07:19:28.037' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'b5f764a3-aff5-48df-8bb1-664b8aa65456', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'8z3cpoziqNJ/ebx7MLIwRe+AbqhSsA3+dFBhofJzXD8=', 1, N'Bfd6DRokM7/5COf8VQJyaA==', N'paulinus@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-12-07 08:47:10.297' AS DateTime), CAST(N'2017-12-07 08:47:10.297' AS DateTime), CAST(N'2017-12-07 08:47:10.297' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'8e6617ef-a4df-493c-a65c-71d6114551e7', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'/wybpI7DbLxA94F2W94WnBXP/anor9t3Kb/2Fz5T5r0=', 1, N'XftLcv8+qk7ZlQ/Cm72vPQ==', N'julianto.saut@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-01 05:52:58.973' AS DateTime), CAST(N'2017-11-01 05:52:58.973' AS DateTime), CAST(N'2017-11-01 05:52:58.973' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'57cf2183-76c2-4846-a65b-7b8c33d63656', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'4EYaF9eu12eMTXgfiE4IjiDzh+fgUcy04uMtS6Zmy2A=', 1, N'2WWhsrnGanm4CKzAkT1NBg==', N'ptg.dashboard1@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-10-30 09:32:47.233' AS DateTime), CAST(N'2017-11-10 06:19:53.610' AS DateTime), CAST(N'2017-10-30 09:32:47.233' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'e3609749-7fbf-4341-ad38-7d9104152cc9', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'GG+E6Im+s7pZBStMhrOYtfew58ae2vgb1an5IauIMuM=', 1, N'anq7TVZNVUGLDNLgdejVnw==', N'dimas.wibiyanto@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-06 09:40:26.543' AS DateTime), CAST(N'2017-11-10 03:22:22.817' AS DateTime), CAST(N'2017-11-06 09:40:26.543' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'91809d8f-4ee0-43ea-ac92-89b8b0aa0c67', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'1/c3fc+hEaIA4WqJKVfInIsO2rb+stsbbmKkcvfqJdI=', 1, N'OKJbF4zj2A6ShXlGYwfE8Q==', N'rivadino.riza@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-12-06 23:31:29.767' AS DateTime), CAST(N'2017-12-06 23:31:29.767' AS DateTime), CAST(N'2017-12-06 23:31:29.767' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'59320647-0422-4fd1-9d99-a19df93aa041', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'wMEp7iBpmlvbHROWHusMrfAYVgW42FJHskXeyy3zZpE=', 1, N'LDxcdDnFo0mMFxmFiFZGzg==', N'mk.dimas@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-14 01:35:50.830' AS DateTime), CAST(N'2017-11-14 01:35:50.830' AS DateTime), CAST(N'2017-11-14 01:35:50.830' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'330c769c-2fb6-40cf-9608-a900fcd4654a', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'kLGZro9U+ZW/oIKP15Ez9be3ByDq8brkz6OEaw+36Nk=', 1, N'uNWK+Rp6WSDoT2Vb3N2qRA==', N'suko.hartono@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-06 01:46:46.247' AS DateTime), CAST(N'2017-12-04 06:20:44.640' AS DateTime), CAST(N'2017-11-06 01:46:46.247' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'4b51f891-2f19-44bf-9c1d-b08cbc2c719d', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'uKgeVcUbTv4qA7VyGPofm9dfrkxQcLQXD/NbXGYBBq8=', 1, N'dNqmm0OL42f1tde4zzrqfQ==', N'nova.febrina@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-15 08:09:04.303' AS DateTime), CAST(N'2017-11-15 08:09:04.303' AS DateTime), CAST(N'2017-11-15 08:09:04.303' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'd47092e2-ce14-4842-8b74-ba47579f517c', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'mJ+rC0GQPnrqQh+4AkwXsrS24I0BIIKZ+uU9RATudOM=', 1, N'U25wb0Y41BeNXqROM1U+Jw==', N'eko.susanto@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-27 00:36:39.477' AS DateTime), CAST(N'2017-11-27 00:36:39.477' AS DateTime), CAST(N'2017-11-27 00:36:39.477' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'd8ce7913-28bb-485b-8268-c2d512c15346', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'e9X8YT7sbV26JTowu1/lyoyOWNiOf8NOjnQHsiS4aoE=', 1, N'PRyAGDkBP/67bsbEc0ez8A==', N'iif.yusuf@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-02 06:54:49.240' AS DateTime), CAST(N'2018-01-10 06:14:57.660' AS DateTime), CAST(N'2017-11-02 06:54:49.240' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'00b70656-b11a-4eba-8b43-caa83dad07ec', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'oWm3MRRB9qPzBhaMZxaM1qvhRU7Uchv3vg8zU6uRacI=', 1, N'cmj8HYcCoKwunvlK4Ct3/g==', N'yuniver@pertamina.com', NULL, NULL, 1, 0, CAST(N'2018-01-10 07:09:34.977' AS DateTime), CAST(N'2018-01-10 07:09:34.977' AS DateTime), CAST(N'2018-01-10 07:09:34.977' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'36c91692-bb1d-49a1-9c97-d2d7217630e0', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'6AkUV2XJbf6cxh/ihxI0Yugn8l32nT+TLWio58C9DRI=', 1, N'4odQLl5CUoaYwo0B0vTGeA==', N'hpmarbun@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-08 04:46:21.167' AS DateTime), CAST(N'2017-11-08 06:20:49.480' AS DateTime), CAST(N'2017-11-08 04:46:21.167' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'70a3f187-83bc-4244-af9d-e8cdcf394443', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'9S8HgWaX/hOc4s/zogG+37ax9blDDIObE5ZL/zuRxfs=', 1, N'PWINyFiSAqESG+mVa66aKQ==', N'yosie.andrianto@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-02 07:01:27.090' AS DateTime), CAST(N'2017-11-02 07:01:27.090' AS DateTime), CAST(N'2017-11-02 07:01:27.090' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Memberships] ([UserId], [ApplicationId], [Password], [PasswordFormat], [PasswordSalt], [Email], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowsStart], [Comment]) VALUES (N'ca4950b4-ac65-442b-8766-ee88b09ef67c', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'4H4qIwskYIfHSby4Ar0YfAqjF6SoGOU5ZnvIz3J0lQU=', 1, N'4QhsaHU6XNZX2lEVHLeYrg==', N'ivan.md@pertamina.com', NULL, NULL, 1, 0, CAST(N'2017-11-01 05:18:09.383' AS DateTime), CAST(N'2017-11-07 17:30:38.653' AS DateTime), CAST(N'2017-11-01 05:18:09.383' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'80d319c4-c065-456f-b5dd-00789cc20ade', N'Investment Sync', N'Investment')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'21a9eded-3ef1-4747-8f3d-15eeecf29e93', N'Security Guard', NULL)
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'7dbc7311-90ca-40e0-a571-3080f0968cab', N'Finance Update', N'Finance')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'e4a21a32-1faf-4731-b7e5-426c5a4259a7', N'Investment View', N'Investment')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'9f49b09e-622b-4051-8550-5ba15f7ff811', N'Investment Update', N'Investment')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'de73c317-35c1-4625-8be1-64586d029943', N'Risk Update', N'Risk')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'e6b8ad7c-2072-41ec-b19a-817c9dee7bc0', N'Finance Sync', N'Finance')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'257a49a4-d6ea-439b-965f-ae01bb82a863', N'Finance View', N'Finance')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'c91435c6-121d-4e75-b955-af4ebe71d679', N'Authorize Module', NULL)
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'f0c9850b-05fb-462c-9068-b71e899444c4', N'Operation Update', N'Operation')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'5395a095-d037-4d70-8f32-caf0cb61d6e6', N'Operation Sync', N'Operation')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'8e09d705-3012-46e1-b000-d97dc691e65f', N'Operation View', N'Operation')
INSERT [dbo].[Modules] ([Id], [ModuleName], [ParentModule]) VALUES (N'28556315-3b33-4675-8e86-fc4886c6c879', N'Risk View', N'Risk')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'64b31528-f298-4682-b279-266ddfa4252e', N'2c446663-554b-4d28-98f1-740be9e5f3de', N'8e09d705-3012-46e1-b000-d97dc691e65f')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'0db40530-3e25-45f8-a473-32b58648efa4', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'80d319c4-c065-456f-b5dd-00789cc20ade')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'e360bd61-fe65-4bb3-b0ed-40072cda3e11', N'df5cf87d-a32d-4a68-8aa6-753d186b758a', N'de73c317-35c1-4625-8be1-64586d029943')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'352638db-7f3f-4b1b-aa24-4a87085718cc', N'2c446663-554b-4d28-98f1-740be9e5f3de', N'28556315-3b33-4675-8e86-fc4886c6c879')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'b122e343-cf1f-4be9-ab4b-4d2b33367f5d', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'7dbc7311-90ca-40e0-a571-3080f0968cab')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'be9dc26a-598e-40a5-8da8-5e5c515c1a89', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'9f49b09e-622b-4051-8550-5ba15f7ff811')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'a9eea255-5519-4c4d-9318-62c06e2fa805', N'df5cf87d-a32d-4a68-8aa6-753d186b758a', N'8e09d705-3012-46e1-b000-d97dc691e65f')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'7eb8944d-3ca7-472f-bbb2-6b9dfb02dcc7', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'257a49a4-d6ea-439b-965f-ae01bb82a863')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'74841ca7-ce1e-4455-9b2b-7023e612eeb9', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'e4a21a32-1faf-4731-b7e5-426c5a4259a7')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'3495c233-f7e6-42ce-b42d-7848486fccc5', N'df5cf87d-a32d-4a68-8aa6-753d186b758a', N'28556315-3b33-4675-8e86-fc4886c6c879')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'50df1562-79ad-404e-9c29-99df183e0e6c', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'f0c9850b-05fb-462c-9068-b71e899444c4')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'c1ba4b80-2b6f-4c52-adb5-a18907bdbf59', N'2c446663-554b-4d28-98f1-740be9e5f3de', N'257a49a4-d6ea-439b-965f-ae01bb82a863')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'e9904927-85bb-4944-8294-addad1079555', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'c91435c6-121d-4e75-b955-af4ebe71d679')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'2c3ee86f-ebc4-4cd4-869d-aeaf94ef8a21', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'8e09d705-3012-46e1-b000-d97dc691e65f')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'6716d2ce-aff6-4d39-a792-bbbfea5d2e9b', N'df5cf87d-a32d-4a68-8aa6-753d186b758a', N'e4a21a32-1faf-4731-b7e5-426c5a4259a7')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'38fef1df-e3da-4b12-bcf3-ce692ccc6740', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'e6b8ad7c-2072-41ec-b19a-817c9dee7bc0')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'25ffe728-5005-4aeb-b971-d06e256b5f5b', N'df5cf87d-a32d-4a68-8aa6-753d186b758a', N'257a49a4-d6ea-439b-965f-ae01bb82a863')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'da3e3903-5900-4d83-9c51-d200f9bb65dd', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f', N'c91435c6-121d-4e75-b955-af4ebe71d679')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'f05b435d-4193-4009-baff-d3c96b9e27ee', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'21a9eded-3ef1-4747-8f3d-15eeecf29e93')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'409ee262-e64e-440e-a494-df170123725b', N'2c446663-554b-4d28-98f1-740be9e5f3de', N'e4a21a32-1faf-4731-b7e5-426c5a4259a7')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'cc07387d-9b15-4ab8-91bc-ff14bdfdcf9e', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'28556315-3b33-4675-8e86-fc4886c6c879')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'f78c716b-2572-4034-8e4a-ff6b0959190a', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'5395a095-d037-4d70-8f32-caf0cb61d6e6')
INSERT [dbo].[ModulesInRoles] ([Id], [RoleId], [ModuleId]) VALUES (N'8324c89c-a8b9-4e1e-967d-ffffefa99355', N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'de73c317-35c1-4625-8be1-64586d029943')
SET IDENTITY_INSERT [dbo].[Risk] ON 

INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1041, 2017, N'Pendapatan Operasi', N'Liquiduty & Finance Intelligence', N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Potensi risiko keterlambatan penerimaan dana atas piutang dagang</span>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'YELLOW', N'QUANTITATIVE', N'PTG-2017-001', N'admin', CAST(N'2017-09-18 18:12:59.687' AS DateTime), N'admin', CAST(N'2017-09-18 18:12:59.687' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1042, 2017, N'Transportasi Gas', N'Liquiduty & Finance Intelligence', N'Potensi risiko tidak tercapainya target volume pengaliran gas', N'<ol><li><span style="color:#676a6c;font-family:open sans, Helvetica Neue, Helvetica, Arial, sans-serif;"><span style="font-size:13px;">Menurunnya daya serap pasar eksisting (West Java Area, East Java Area).</span></span></li><li><span style="color:#676a6c;font-family:open sans, Helvetica Neue, Helvetica, Arial, sans-serif;"><span style="font-size:13px;">Rendahnya daya serap pasar baru (West Java Area, North Sumatera Area, East Java Area)</span></span></li><li>Mundurnya penyelesaian proyek infrastruktur (Pipa Semare, Grissik-Pusri, PKG Looping)</li><li>Gangguan pada operasi pipa eksisting&nbsp;</li><li>Menurunnya produksi gas dari sumur eksisting (West Java Area, East Java Area)</li><li>Potensi penurunan toll fee pada ruas pipa Arbel-kim-kek</li></ol>', N'Menurunnya realisasi serapan pada Jumlah Penyeluruhan Harian (JPH) pada periode Sebelumnya ', N'<div><span style="color:#676a6c;font-family:open sans, Helvetica Neue, Helvetica, Arial, sans-serif;"><span style="font-size:13px;">Adanya klausul Ship or Pay</span></span></div>', N'<div><span style="color:#676a6c;font-family:open sans, Helvetica Neue, Helvetica, Arial, sans-serif;"><span style="font-size:13px;"><br /></span></span></div>Financial Loss', N'YELLOW', N'QUALITATIVE', N'PTG-2017-002', N'admin', CAST(N'2017-09-18 18:17:48.000' AS DateTime), N'admin', CAST(N'2017-10-11 14:26:43.660' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1043, 2017, N'Gas Processing', N'Liquidity & Finance Intelligence', N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Potensi risiko tidak tercapainya target volume produksi LPG</span>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'YELLOW', N'QUANTITATIVE', N'PTG-2017-003', N'admin', CAST(N'2017-09-18 18:20:21.000' AS DateTime), N'admin', CAST(N'2017-09-18 18:21:56.180' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1044, 2017, N'Penjualan Gas', N'Gas Sales Section', N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Potensi risiko tidak tercapainya target volume niaga gas</span>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'YELLOW', N'QUANTITATIVE', N'PTG-2017-004', N'admin', CAST(N'2017-09-18 18:23:07.000' AS DateTime), N'admin', CAST(N'2017-09-18 18:23:15.663' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1045, 2017, N'Regasifikasi', N'Liquidity & Finance Intelligence', N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Potensi risiko tidak tercapainya target volume penyerapan gas hasil regasifikasi Perta Arun Gas</span>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'GREEN', N'QUALITATIVE', N' PTG-2017-005', N'admin', CAST(N'2017-09-18 18:25:37.000' AS DateTime), N'admin', CAST(N'2017-09-18 18:25:47.137' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1046, 2016, N'Pendapatan Operasi', N'Liquidity & Finance Intelligence', N'Potensi pengeluaran tambahan pada bagian operasional gas', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Customer kesulitan dalam pendanaan internal.</li><li style="box-sizing:border-box;">Kendala operasional &amp; komersial di Costumer.</li><li style="box-sizing:border-box;">Kendala kinerja serapan dari end user gas.</li></ol>', N'Pembayaran dari debitur melebihi tanggal jatuh tempo.', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">ME (Mutiara Energi) setuju untuk menjaminkan infrastruktur pipa milik ME ruas PDT-TGD 12"" sepanjang &plusmn; 36 Km</li><li style="box-sizing:border-box;">Pertagas dan PTGN telah mengirimkan surat peringatan kepada debitur dan Fungsi Operasi</li><li style="box-sizing:border-box;">Terdapat klausul penempatan Stand By Letter of Credit untuk SBLC masing-masing Costumer yang bertransaksi dengan Pertagas</li><li style="box-sizing:border-box;">Fungsi Keuangan telah melakukan korespondensi untuk melakukan penutupan aliran gas</li></ol>', N'<ol style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Cashflow perusahaan terganggu</li><li style="box-sizing:border-box;">Mengurangi laba bersih</li><li style="box-sizing:border-box;">Impairment</li></ol>', N'YELLOW', N'QUALITATIVE', N'PTG-2016-001', N'admin', CAST(N'2017-09-18 18:31:07.880' AS DateTime), N'admin', CAST(N'2017-09-18 18:31:07.880' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1047, 2017, N'Gas Processing', N'External Factor', N'<p>Potensi resiko tidak tercapainya target volume pengaliran gas&nbsp;</p>', N'<p>1. Penurunan Feed Gas Rate dari Pertamina EP</p><p>2. Punurunan komposisi C3 dan C4</p><p>3. Kandungan uap air (moisture) dalam feed gas tinggi&nbsp;</p><p>4. Material hasil pigging di pipa 28" milik Pertamina EP berpotensi masuknya cairan ke dalam sistem unit ekstrasi sehigga mengharuskan PSG menurunkan volume feed gas untuk menghindari liquid carry over</p>', N'Turunnya Pressure pada feed Gas', N'<p>1. Manajemen PSG telah berkoordinasi dengan PT Pertamina EP untuk komitmen penyaluran Feed Gas ke PSG&nbsp;</p><p>2. Pertamina Ep sedang membangun pipa dari Musi Timur ke Musi Barat agar gas dapat disalurkan ke Dehydration Unit (DHU) di Musi Barat&nbsp;</p>', N'<p>1. Menurunkan kehandalan dan efisiensi dari Plant&nbsp;</p><p>2. Penurunan produksi LPG dan Condensate&nbsp;</p><p>3. Menurunkan performance perusahaan</p>', N'RED', N'QUANTITATIVE', N'PSG-2017-001', N'admin', CAST(N'2017-10-10 14:07:54.773' AS DateTime), N'admin', CAST(N'2017-10-10 14:07:54.773' AS DateTime), 1)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1048, 2017, N'Gas Processing', N'External Factor ', N'Potensi risiko tidak tercapainya target volume produksi LPG', N'<p>1. Penurunan Feed Gas Rate dari Pertamina EP&nbsp;</p><p>2. Penurunan komposisi C3 dan C4&nbsp;</p><p>3. Kandungan uap air (moisture) dalam feed gas tinggi</p><p>4. Material hasil pigging di pipa 28" mililk Pertamina EP berpotensi masuknya cairan kedalam sistem unit ekstrasi sehingga mengaharuskan PSG menurunkan volume feed gas untuk menghindari liquid carry over&nbsp;</p>', N'Turunnya pressure pada feed gas', N'<p>1. Manajemen PSG telah berkoordinasi dengan PT Pertamina EP untuk berkomitmen penyaluran Feed Gas ke PSG</p><p>2. Pertamina EP sedang membangun pipa dari Musi Timur ke Musi Barat agar gas dapat disalurkan ke Dehydration Unit (DHU) di Musi Barat</p>', N'<p>1. Menurunkan kehandalan dan efisiensi dari Plant&nbsp;</p><p>2. Penurunan produksi LPG dan Condensate&nbsp;</p><p>3. Menurunkan performance Perusahaan&nbsp;</p>', N'RED', N'QUANTITATIVE', N'PSG-2017-001', N'admin', CAST(N'2017-10-10 14:32:33.700' AS DateTime), N'admin', CAST(N'2017-10-10 14:32:33.700' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1049, 2017, N'Penjualan Gas', N'Sales Marekting and Communications ', N'Potensi risiko tidak tercapainya targeet volume niaga gas', N'<p>1. Penurunan kapasitas produksi end user</p><p>2. Skema pasokan gas ke beberapa konsumen adalah "as available"&nbsp;</p><p>3. Gangguan pada sistem penyaluran, perpipaan dan transportasi non pipa.</p><p>4. Tidak diperolehnya alokasi:</p><p style="margin-left:30px;">a. Alokasi LNG untuk niaga di Sumatera Bagian Utara (regas &amp; trucking), Jawa Bagian Barat (regas) dan Kalimantan (trucking)&nbsp;</p><p style="margin-left:30px;">b. Alokasi gas lapangan untuk niaga di Sumatera Bagian Selatan (gas JOB Pertamina Talisman Jambi Merang dan PEP Paku Gajah), Jawa Baagian Barat (gas PHE ONWJ Cilamaya) dan Jawa Bagian Timur (gas Lapindo Brantas Indonesia)&nbsp;</p><p style="margin-left:30px;">c. Tidak bisanya dilakukan mekanisme SWAP LNG secara parsial, harus full 1 cargo.</p><p>5. Tidak terealisasinya PJBG dengan konsumen baru akibat konsumen batal menggunakan gas atau harga tidak bersaing.</p><p>6. Keterlambatan penyelesaian infrastruktur untuk konsumen baru:</p><p style="margin-left:30px;">a. Pembangunan pipa distribusi</p><p style="margin-left:30px;">b. Pembangunan Jargas</p><p style="margin-left:30px;">c. Pembangunan filling station (upgrade kapasitas Plant 26)&nbsp;</p>', N'Penyerapan gas oleh beberapa konsumen eksisting masih dibawah kontrak', N'Sudah rutin dilaksanakan koordinasi dengan konsumen&nbsp;', N'<p>1. Tidak tercapainya target volume niaga gas.</p><p>2. Tidak tercapainya target volume niaga gas.&nbsp;</p>', N'RED', N'QUANTITATIVE', N'PTGN-2017-001', N'admin', CAST(N'2017-10-10 15:02:16.000' AS DateTime), N'admin', CAST(N'2017-10-12 08:57:49.893' AS DateTime), 0)
INSERT [dbo].[Risk] ([RiskId], [Year], [ProcessBusiness], [RiskCategory], [RiskEvent], [RiskAgent], [KRI], [Controll], [QualitatifImpact], [RiskClasification], [QualitatifQuantitatifRisk], [RiskNumber], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (1050, 2017, N'Regasifikasi ', N'External Factor ', N'Potensi risiko tidak tercapainya target volume penyerapan gas hasil regasifikasi Perta Arun Gas&nbsp;', N'<p>1. Konsumen mengurangi target serapan gas (PLN&amp;PTGN)&nbsp;</p><p>2. Unscheduled shutdown konsumen&nbsp;</p><p>3. Adanya substitusi energi (dual fuel)</p><p>4. Unscheduled shutdown PAG atau PTG</p><p>5. Gangguan operasi pipa arbel</p>', N'Perencanaan penyerapan gas dari (PLN & PTGN) di tahun 2015 tidak sesuai dengan target minimal 95 MMSCFD ', NULL, N'<p>1. Target volume regasifikasi tidak tercapai</p><p>2. Mundurnya pengiriman kargo berikutnya&nbsp;</p>', N'RED', N'QUANTITATIVE', N'PAG-2017-001', N'admin', CAST(N'2017-10-10 15:15:23.733' AS DateTime), N'admin', CAST(N'2017-10-10 15:15:23.733' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Risk] OFF
SET IDENTITY_INSERT [dbo].[RiskImpact] ON 

INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (10, 1041, N'INHERENT', 12573, 5, 5, 25, N'admin', CAST(N'2017-09-18 18:13:27.513' AS DateTime), N'admin', CAST(N'2017-09-18 18:13:27.513' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (11, 1041, N'RESIDUAL', 12573, 2, 1, 2, N'admin', CAST(N'2017-09-18 18:13:27.540' AS DateTime), N'admin', CAST(N'2017-09-18 18:13:27.540' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (12, 1042, N'INHERENT', 10512, 5, 5, 30, N'admin', CAST(N'2017-09-18 18:19:20.000' AS DateTime), N'admin', CAST(N'2017-10-11 14:28:15.473' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (13, 1042, N'RESIDUAL', 262811, 2, 1, 2, N'admin', CAST(N'2017-09-18 18:19:20.000' AS DateTime), N'admin', CAST(N'2017-10-11 14:28:15.750' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (14, 1043, N'INHERENT', 5345, 4, 1, 43, N'admin', CAST(N'2017-09-18 18:20:40.157' AS DateTime), N'admin', CAST(N'2017-09-18 18:20:40.157' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (15, 1043, N'RESIDUAL', 4275, 3, 3, 40, N'admin', CAST(N'2017-09-18 18:20:40.173' AS DateTime), N'admin', CAST(N'2017-09-18 18:20:40.173' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (16, 1044, N'INHERENT', 35536, 4, 3, 21, N'admin', CAST(N'2017-09-18 18:23:38.853' AS DateTime), N'admin', CAST(N'2017-09-18 18:23:38.853' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (17, 1044, N'RESIDUAL', 34854, 3, 3, 23, N'admin', CAST(N'2017-09-18 18:23:38.870' AS DateTime), N'admin', CAST(N'2017-09-18 18:23:38.870' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (18, 1045, N'INHERENT', 678, 1, 3, 511, N'admin', CAST(N'2017-09-18 18:26:13.183' AS DateTime), N'admin', CAST(N'2017-09-18 18:26:13.183' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (19, 1045, N'RESIDUAL', 768, 2, 3, 515, N'admin', CAST(N'2017-09-18 18:26:13.203' AS DateTime), N'admin', CAST(N'2017-09-18 18:26:13.203' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (20, 1046, N'INHERENT', 4324, 3, 2, 34, N'admin', CAST(N'2017-09-18 18:31:21.983' AS DateTime), N'admin', CAST(N'2017-09-18 18:31:21.983' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (21, 1046, N'RESIDUAL', 1231, 2, 4, 32, N'admin', CAST(N'2017-09-18 18:31:22.000' AS DateTime), N'admin', CAST(N'2017-09-18 18:31:22.000' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (22, 1047, N'INHERENT', 2579, 5, 2, 10, N'admin', CAST(N'2017-10-10 14:13:06.973' AS DateTime), N'admin', CAST(N'2017-10-10 14:13:06.973' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (23, 1047, N'RESIDUAL', 1289, 3, 1, 3, N'admin', CAST(N'2017-10-10 14:13:07.230' AS DateTime), N'admin', CAST(N'2017-10-10 14:13:07.230' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (24, 1047, N'INHERENT', 2579, 5, 2, 10, N'admin', CAST(N'2017-10-10 14:13:38.467' AS DateTime), N'admin', CAST(N'2017-10-10 14:13:38.467' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (25, 1047, N'RESIDUAL', 1289, 3, 1, 3, N'admin', CAST(N'2017-10-10 14:13:38.490' AS DateTime), N'admin', CAST(N'2017-10-10 14:13:38.490' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (26, 1048, N'INHERENT', 2579, 5, 2, 10, N'admin', CAST(N'2017-10-10 14:34:06.457' AS DateTime), N'admin', CAST(N'2017-10-10 14:34:06.457' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (27, 1048, N'RESIDUAL', 1289, 3, 1, 3, N'admin', CAST(N'2017-10-10 14:34:06.727' AS DateTime), N'admin', CAST(N'2017-10-10 14:34:06.727' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (28, 1050, N'INHERENT', 1998, 4, 2, 8, N'admin', CAST(N'2017-10-10 15:16:44.170' AS DateTime), N'admin', CAST(N'2017-10-10 15:16:44.170' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (29, 1050, N'RESIDUAL', 19976, 2, 1, 2, N'admin', CAST(N'2017-10-10 15:16:44.333' AS DateTime), N'admin', CAST(N'2017-10-10 15:16:44.333' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (30, 1049, N'INHERENT', 2273, 5, 2, 12, N'admin', CAST(N'2017-10-11 13:51:33.330' AS DateTime), N'admin', CAST(N'2017-10-11 13:51:33.330' AS DateTime), 0)
INSERT [dbo].[RiskImpact] ([ImpactId], [RiskId], [Type], [QuantitatifImpact], [Probability], [Impact], [RPN], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (31, 1049, N'RESIDUAL', 45462, 2, 1, 2, N'admin', CAST(N'2017-10-11 13:51:33.563' AS DateTime), N'admin', CAST(N'2017-10-11 13:51:33.563' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[RiskImpact] OFF
SET IDENTITY_INSERT [dbo].[RiskMitigation] ON 

INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (30, 1041, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Pertagas telah mengirimkan surat somasi ke ME pada bulan September 2016, setelah somasi dilayangkan dan direspon oleh pihak ME berupa ketidaksanggupan pelunasan piutang sesuai somasi, maka akan dilanjutkan dengan mediasi.</span>', 7, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:13:46.697' AS DateTime), N'admin', CAST(N'2017-09-18 18:13:46.697' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (31, 1041, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Pertagas akan melakukan somasi kepada Odira untuk melakukan pelunasan piutang.</span>', 4, 5, NULL, NULL, N'admin', CAST(N'2017-09-18 18:14:06.613' AS DateTime), N'admin', CAST(N'2017-09-18 18:14:06.613' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (32, 1041, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Mencari peluang melakukan pelunasan piutang ME &amp; Odira melalui offseting di Pertamina Group.</span>', 2, 2, NULL, NULL, N'admin', CAST(N'2017-09-18 18:14:16.813' AS DateTime), N'admin', CAST(N'2017-09-18 18:14:16.813' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (33, 1042, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan komunikasi dan koordinasi secara intensif dengan Pertagas Niaga untuk meningkatkan penyerapan pasar eksisting &amp; pasar baru dan dengan KKKS untuk memastikan suplai gas lancar</span>', 3, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:18:15.313' AS DateTime), N'admin', CAST(N'2017-09-18 18:18:15.313' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (34, 1042, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan percepatan proses penyelesaian proyek:</span><ul style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Konstruksi pada proyek Pipa Semare</li><li style="box-sizing:border-box;">Konstruksi pada ruas Gresik-Semarang</li><li style="box-sizing:border-box;">Konstruksi pada ruas Grissik-Pusri</li><li style="box-sizing:border-box;">Konstruksi pada ruas PKG Looping</li></ul>', 6, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:18:26.103' AS DateTime), N'admin', CAST(N'2017-09-18 18:18:26.103' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (35, 1042, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Melakukan kegiatan maintenance untuk kehandalan pipa:</span><br style="box-sizing:border-box;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;" /><ul style="box-sizing:border-box;margin-top:0px;margin-bottom:10px;color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;"><li style="box-sizing:border-box;">Perbaikan Erosi ROW Jalur Pipa Gas Distrik Bitung KP 157 (WJA)</li><li style="box-sizing:border-box;">Perbaikan erosi,saluran air dan jembatan di ruas wilayah Cilamaya KP 03.9,KP 005,KP 029.9,KP 00.9,KP 002.4, Erosi di KP 037.5 (WJA)</li><li style="box-sizing:border-box;">Pemasangan Fasilitas Corrosion Monitoring System pada Pipa Penyalur di Wilayah PT Pertamina Gas SSA</li><li style="box-sizing:border-box;">In Line Inspection dengan Intelligent Pig untuk Pipa 20&rdquo; Betung - Benuang, 20&rdquo; Benuang &ndash; Prabumulih Barat, 20&rdquo; Simpang Y &ndash; PUSRI(Looping), 12&rdquo; Limau Timur &ndash; Prabumulih Barat, 12&rdquo; Prabumulih Barat - Cambai</li></ul>', 4, NULL, NULL, NULL, N'admin', CAST(N'2017-09-18 18:18:35.173' AS DateTime), N'admin', CAST(N'2017-09-18 18:18:35.173' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (36, 1042, N'<span style="color:#676a6c;font-family:''open sans'', ''Helvetica Neue'', Helvetica, Arial, sans-serif;font-size:13px;background-color:#ffffff;">Membuat kajian skema bisnis terintegrasi dari hulu ke hilir atas penurunan toll fee untuk meningkatkatkan volume penjualan gas di Sumatera Bagian Utara</span>', 6, 4, NULL, NULL, N'admin', CAST(N'2017-09-18 18:18:46.000' AS DateTime), N'admin', CAST(N'2017-10-11 14:30:11.373' AS DateTime), 0)
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
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (57, 1048, N'<p>Melakukan Proses negosisasi dengan PT Pertamina EP untuk kenaikan volume gas dengan kompensasi penurunan tarif handling fee condensate&nbsp;</p>', 12, 1, NULL, N'Rencana mitigasi tidak ini tidal dilakukan pada triwulan III, sudah dilakukan pada akhir 2016', N'admin', CAST(N'2017-10-10 14:44:23.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:58:11.647' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (58, 1048, N'Mendorong PT Pertamina EP terkait penyediaan sumber gas baru yang kaya kandungan C3 dan C4 bersama dengan fungsi Gas Sourcing Dit. Gas', 3, 3, NULL, N'Nominasi Feed Gas telah disesuaikan menunggu kesepakatan ditandatangani&nbsp;', N'admin', CAST(N'2017-10-10 15:24:39.403' AS DateTime), N'admin', CAST(N'2017-10-10 15:24:39.403' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (59, 1048, N'Melakukan Koordinasi intensif dengan PT Pertamina EP terkait optimalisasi operasi Dehidration Unit milik Pertamina EP di Musi Barat&nbsp;', 3, 3, NULL, N'Koordinasi dengan Produsen gas dilakukan baik dengan internal Pertamina maupun PSC lainnya&nbsp;', N'admin', CAST(N'2017-10-10 15:32:25.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:57:53.923' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (60, 1048, N'Melakukan koordinasi dengan PT Pertamina EP terkait kondisi upstream yang dapat menurunkan supply gas&nbsp;', 6, 6, NULL, N'Optimalisasi Dehydration Unot (DHU) di Musi Barat diharapkan dapat berjalan pada Q3-2017', N'admin', CAST(N'2017-10-10 15:36:02.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:57:41.763' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (61, 1048, N'Melakukan koordinasi dengan PT Pertamina EP terkait pengadaan tambahan slug catcher baru di Prabumulih Barat', 1, 1, NULL, N'Telah dilakukan ditriwulan I', N'admin', CAST(N'2017-10-10 15:38:03.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:57:29.457' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (62, 1049, N'Koordinasi dengan konsumen eksisting terkait fluktuasi volume penyerapan dan tindak lanjutnya', 3, 3, NULL, NULL, N'admin', CAST(N'2017-10-10 15:39:51.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:56:50.077' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (63, 1049, N'Melakukan inspeksi jaringan pipa dan transportasi darat secara rutin&nbsp;', 3, 3, NULL, NULL, N'admin', CAST(N'2017-10-10 15:41:50.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:56:39.870' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (64, 1049, N'Koordinasi secara intensif terkait alokasi LNG dan gas pipa dengan fungsi LNG dan fungsi Gas sourcing Dit. Gas serta melalui forum CIG', 3, 3, NULL, N'<p>War Room dihadiri fungsi Natural Gas Dit. Gas yang mengkoordinasikan kebutuhan alokasi gas dengan fungsi terkait di Dit. GEBT</p><p></p><p>LNG Regasifikasi ditujukan untuk konsumen baru di Jawa Bagian Barat<br /></p>', N'admin', CAST(N'2017-10-10 15:44:43.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:56:28.937' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (65, 1049, N'Mempercepat realisasi PJBG baru dengan:<br />a. Monitoring progress perikatan komersial dengan calon konsumen baru.&nbsp;<br />b. Menggunakan portofolio pasokan untuk mencapai harga yang kompetitif (di wilayah yang memiliki lebih dari 2 sumber pasokan) jika dimungkinkan<br />c. Mempersiapkan konsumen baru dengan volume demand yang lebih besar dari target volume RKAP', 3, 3, NULL, N'Progress perikatan dengan konsumen baru di bahas dalam War Room dan Management Meeting.', N'admin', CAST(N'2017-10-10 15:46:58.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:55:53.630' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (66, 1049, N'<br />Koordinasi intensif dengan konsumen baru terkait kesiapan mereka menyerap gas sesuai target waktu yang disepakati', 6, 7, NULL, NULL, N'admin', CAST(N'2017-10-10 15:47:54.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:55:42.967' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (67, 1049, N'<br />Koordinasi dengan fungsi terkait di Pertagas beserta afiliasi dan konsumen terkait pembangunan infrastruktur', 9, 9, NULL, N'War Room dihadiri fungsi Gas Resourcing &amp; Business Networking Pertagas.', N'admin', CAST(N'2017-10-10 15:48:50.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:55:23.343' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (68, 1049, N'Koordinasi dengan Ditjen Migas dan Pelaksanana pembangunan infrastruktur jargas dan fungsi City Gas Dit. Gas', 6, 9, NULL, NULL, N'admin', CAST(N'2017-10-10 15:49:38.627' AS DateTime), N'admin', CAST(N'2017-10-10 15:49:38.627' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (69, 1049, N'Koordinasi dengan fungsi Business Development Pertagas terkait peningkatan kapasitas penyaluran Plant&nbsp;', 6, 7, NULL, NULL, N'admin', CAST(N'2017-10-10 15:50:28.000' AS DateTime), N'admin', CAST(N'2017-10-10 15:54:59.867' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (70, 1050, N'Memasukkan klausul Use or Pay 90% (94.5 MMSCFD) dalam perjanjian (saat ini masih Kesepakatan Bersama) kepada para konsumen', 12, NULL, NULL, N'Rencana mitigasi ini akan dilaksanakan di akhir tahun 2017', N'admin', CAST(N'2017-10-10 15:52:15.277' AS DateTime), N'admin', CAST(N'2017-10-10 15:52:15.277' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (71, 1050, N'Melakukan koordinasi dan komunikasi dengan PLN terkait dengan unscheduled shutdown', 9, 9, NULL, NULL, N'admin', CAST(N'2017-10-10 15:53:02.033' AS DateTime), N'admin', CAST(N'2017-10-10 15:53:02.033' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (72, 1050, N'Melakukan Planned Maintenance sesuai dengan rekomendasi pabrikan', 9, 9, NULL, NULL, N'admin', CAST(N'2017-10-10 15:53:38.047' AS DateTime), N'admin', CAST(N'2017-10-10 15:53:38.047' AS DateTime), 0)
INSERT [dbo].[RiskMitigation] ([MitigationId], [RiskId], [MitigationPlan], [Plan], [Actual], [Evidence], [notes], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsDeleted]) VALUES (73, 1050, N'Menyusun kajian pola serapan bulanan konsumen (PLN &amp; PTGN)', 9, 9, NULL, NULL, N'admin', CAST(N'2017-10-10 15:54:35.230' AS DateTime), N'admin', CAST(N'2017-10-10 15:54:35.230' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[RiskMitigation] OFF
INSERT [dbo].[Roles] ([RoleId], [ApplicationId], [RoleName], [Description]) VALUES (N'8a0a07b9-3335-4e79-ae72-22f8a3684046', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'Admin Keuangan', NULL)
INSERT [dbo].[Roles] ([RoleId], [ApplicationId], [RoleName], [Description]) VALUES (N'9ec79aee-b56c-469f-b26a-5ebe975cb11f', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'Administrator', NULL)
INSERT [dbo].[Roles] ([RoleId], [ApplicationId], [RoleName], [Description]) VALUES (N'2c446663-554b-4d28-98f1-740be9e5f3de', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'Board of Direction', NULL)
INSERT [dbo].[Roles] ([RoleId], [ApplicationId], [RoleName], [Description]) VALUES (N'df5cf87d-a32d-4a68-8aa6-753d186b758a', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'Admin Risk Management', NULL)
INSERT [dbo].[Roles] ([RoleId], [ApplicationId], [RoleName], [Description]) VALUES (N'e2216bff-90ce-4f25-a18c-93b4ba200337', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'Superadmin', N'Superadmin')
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'451a8a97-a75d-4916-b4f2-06ce3be8af41', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'rahadiang.kusumo', 0, CAST(N'2017-11-01 05:06:41.197' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'2be80de0-18e5-42b7-b6ac-081d2dccef96', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'ivan.m', 0, CAST(N'2017-11-09 02:45:40.510' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'09af6c22-b787-4bd2-8580-20a3b5c6db83', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'mk.martha.fiski', 0, CAST(N'2017-11-02 07:02:05.187' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'cb4df1fb-ce3e-4305-bbad-29f39c8e5ed6', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'mk.atus.gestyanto', 0, CAST(N'2017-12-29 02:16:01.273' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'2ad7e935-4af0-482c-a710-2a633d5a349b', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'mk.oki.handoko', 0, CAST(N'2017-11-03 02:12:03.637' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'377095d0-9ce5-4932-b5c1-2e9905dabfcd', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'izzul.naisan', 0, CAST(N'2017-11-07 17:47:38.583' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'01b9718f-b1ef-40e6-88d7-32d110d4ade4', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'syaftiria', 0, CAST(N'2017-11-14 03:39:52.237' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'0047d7f4-27f4-4555-b57a-330603eaa4c1', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'admin', 0, CAST(N'2017-11-06 11:31:16.387' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'9b7610bb-adb4-4573-9d9d-3bfa909448c8', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'rahmat.nasution', 0, CAST(N'2017-11-02 07:00:28.667' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'd72c2853-1f9f-415d-9531-3ccd96ec3814', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'marindra', 0, CAST(N'2018-01-16 03:04:12.277' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'5f7043b2-ad31-47e8-98da-4424b3fd4986', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'erna.kusumadewi', 0, CAST(N'2017-11-28 07:35:34.753' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'21aa5118-4106-4b58-8132-4ccfd0858ce5', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'rahim.hanifah', 0, CAST(N'2017-11-02 06:59:08.637' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'3d7b6e65-498e-49f7-8e30-4ff3318a2e91', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'rully.hidayat', 0, CAST(N'2018-01-12 03:17:44.707' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'e0840d9b-f0d7-4472-b560-53fa572259cd', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'sri.harlinda', 0, CAST(N'2018-01-09 07:43:41.397' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'86d77348-a917-4efd-b038-5515bf3b264e', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'aherry', 0, CAST(N'2017-11-02 07:19:28.050' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'b5f764a3-aff5-48df-8bb1-664b8aa65456', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'paulinus', 0, CAST(N'2017-12-07 08:47:10.377' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'8e6617ef-a4df-493c-a65c-71d6114551e7', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'julianto.saut', 0, CAST(N'2017-11-01 05:52:58.973' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'156a2cd8-1b66-46be-8536-758efd2d96d8', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'Indra.setyawati', 0, CAST(N'2017-11-06 05:34:42.423' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'cce9651d-f8df-4ccc-a571-7801813fe541', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'Tenny_r', 0, CAST(N'2017-11-07 10:23:57.213' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'57cf2183-76c2-4846-a65b-7b8c33d63656', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'ptg.dashboard1', 0, CAST(N'2017-11-10 06:19:53.610' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'e3609749-7fbf-4341-ad38-7d9104152cc9', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'dimas.wibiyanto', 0, CAST(N'2017-11-10 03:22:22.817' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'91809d8f-4ee0-43ea-ac92-89b8b0aa0c67', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'rivadino.riza', 0, CAST(N'2017-12-06 23:31:29.953' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'59320647-0422-4fd1-9d99-a19df93aa041', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'mk.dimas', 0, CAST(N'2017-11-14 01:35:51.033' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'330c769c-2fb6-40cf-9608-a900fcd4654a', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'suko.hartono', 0, CAST(N'2017-12-04 06:20:44.640' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'4b51f891-2f19-44bf-9c1d-b08cbc2c719d', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'nova.febrina', 0, CAST(N'2017-11-15 08:09:04.507' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'd47092e2-ce14-4842-8b74-ba47579f517c', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'eko.susanto', 0, CAST(N'2017-11-27 00:36:39.680' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'd8ce7913-28bb-485b-8268-c2d512c15346', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'iif.yusuf', 0, CAST(N'2018-01-10 06:14:57.660' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'00b70656-b11a-4eba-8b43-caa83dad07ec', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'yuniver', 0, CAST(N'2018-01-10 07:09:35.193' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'36c91692-bb1d-49a1-9c97-d2d7217630e0', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'hpmarbun', 0, CAST(N'2017-11-08 06:20:49.480' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'70a3f187-83bc-4244-af9d-e8cdcf394443', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'Sri.widyaningsih', 0, CAST(N'2017-11-02 07:01:27.107' AS DateTime))
INSERT [dbo].[Users] ([UserId], [ApplicationId], [UserName], [IsAnonymous], [LastActivityDate]) VALUES (N'ca4950b4-ac65-442b-8766-ee88b09ef67c', N'dec31929-927f-4e08-9d59-3e5e29ad2940', N'ivan.md', 0, CAST(N'2017-11-07 17:30:38.653' AS DateTime))
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'377095d0-9ce5-4932-b5c1-2e9905dabfcd', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'9b7610bb-adb4-4573-9d9d-3bfa909448c8', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'd72c2853-1f9f-415d-9531-3ccd96ec3814', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'd72c2853-1f9f-415d-9531-3ccd96ec3814', N'e2216bff-90ce-4f25-a18c-93b4ba200337')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'86d77348-a917-4efd-b038-5515bf3b264e', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'156a2cd8-1b66-46be-8536-758efd2d96d8', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'cce9651d-f8df-4ccc-a571-7801813fe541', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'e3609749-7fbf-4341-ad38-7d9104152cc9', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'330c769c-2fb6-40cf-9608-a900fcd4654a', N'2c446663-554b-4d28-98f1-740be9e5f3de')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'36c91692-bb1d-49a1-9c97-d2d7217630e0', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'70a3f187-83bc-4244-af9d-e8cdcf394443', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
INSERT [dbo].[UsersInRoles] ([UserId], [RoleId]) VALUES (N'ca4950b4-ac65-442b-8766-ee88b09ef67c', N'9ec79aee-b56c-469f-b26a-5ebe975cb11f')
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_UserName]    Script Date: 1/16/2018 10:11:06 AM ******/
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
ON DELETE CASCADE
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
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [RoleEntity_Application]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [User_Application] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
ON DELETE CASCADE
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
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRole_User]
GO
USE [master]
GO
ALTER DATABASE [DB_DSHB_RISK] SET  READ_WRITE 
GO
