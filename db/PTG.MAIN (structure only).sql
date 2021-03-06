USE [master]
GO
/****** Object:  Database [PTG.MAIN]    Script Date: 18-Sep-17 6:48:31 PM ******/
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
/****** Object:  Table [dbo].[Actions]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[ActionsInModules]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[ActionsInModulesChosen]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[Applications]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[log]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[Memberships]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[Modules]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[ModulesInRoles]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[Risk]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[RiskDocument]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[RiskImpact]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[RiskMitigation]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
/****** Object:  Table [dbo].[UsersInRoles]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_UserName]    Script Date: 18-Sep-17 6:48:32 PM ******/
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
