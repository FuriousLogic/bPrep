
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 10/28/2014 07:01:51
-- Generated from EDMX file: C:\Users\Barry\Documents\Visual Studio 2013\Projects\BPrep\BPrep_BL\Model\BP_Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [BPrep];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_PrepperKit]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Kits] DROP CONSTRAINT [FK_PrepperKit];
GO
IF OBJECT_ID(N'[dbo].[FK_KitItem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Items] DROP CONSTRAINT [FK_KitItem];
GO
IF OBJECT_ID(N'[dbo].[FK_ItemStatusItem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Items] DROP CONSTRAINT [FK_ItemStatusItem];
GO
IF OBJECT_ID(N'[dbo].[FK_SampleKitSampleItem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SampleItems] DROP CONSTRAINT [FK_SampleKitSampleItem];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Preppers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Preppers];
GO
IF OBJECT_ID(N'[dbo].[Kits]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Kits];
GO
IF OBJECT_ID(N'[dbo].[Items]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Items];
GO
IF OBJECT_ID(N'[dbo].[ItemStatus]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ItemStatus];
GO
IF OBJECT_ID(N'[dbo].[SampleKits]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SampleKits];
GO
IF OBJECT_ID(N'[dbo].[SampleItems]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SampleItems];
GO
IF OBJECT_ID(N'[dbo].[Parameters]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Parameters];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Preppers'
CREATE TABLE [dbo].[Preppers] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [ConfirmationRequestSent] datetime  NOT NULL,
    [ConfirmationGuid] nvarchar(max)  NULL,
    [ShowTipKit] bit  NOT NULL,
    [ShowTipKitItems] bit  NOT NULL,
    [UnsubscribeGuid] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Kits'
CREATE TABLE [dbo].[Kits] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Location] nvarchar(max)  NOT NULL,
    [PrepperId] int  NOT NULL
);
GO

-- Creating table 'Items'
CREATE TABLE [dbo].[Items] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [ReplaceBy] datetime  NULL,
    [DaysWarningOfReplacement] int  NOT NULL,
    [KitId] int  NOT NULL,
    [ItemStatusId] int  NOT NULL,
    [Quantity] int  NOT NULL,
    [SampleItemId] int  NULL
);
GO

-- Creating table 'ItemStatus'
CREATE TABLE [dbo].[ItemStatus] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'SampleKits'
CREATE TABLE [dbo].[SampleKits] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'SampleItems'
CREATE TABLE [dbo].[SampleItems] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Quantity] int  NOT NULL,
    [SampleKitId] int  NOT NULL,
    [DaysShelfLife] int  NOT NULL,
    [DaysWarningOfReplacement] int  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [AmazonWidget] nvarchar(max)  NULL
);
GO

-- Creating table 'Parameters'
CREATE TABLE [dbo].[Parameters] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Value] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Preppers'
ALTER TABLE [dbo].[Preppers]
ADD CONSTRAINT [PK_Preppers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Kits'
ALTER TABLE [dbo].[Kits]
ADD CONSTRAINT [PK_Kits]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Items'
ALTER TABLE [dbo].[Items]
ADD CONSTRAINT [PK_Items]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ItemStatus'
ALTER TABLE [dbo].[ItemStatus]
ADD CONSTRAINT [PK_ItemStatus]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'SampleKits'
ALTER TABLE [dbo].[SampleKits]
ADD CONSTRAINT [PK_SampleKits]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'SampleItems'
ALTER TABLE [dbo].[SampleItems]
ADD CONSTRAINT [PK_SampleItems]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Parameters'
ALTER TABLE [dbo].[Parameters]
ADD CONSTRAINT [PK_Parameters]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [PrepperId] in table 'Kits'
ALTER TABLE [dbo].[Kits]
ADD CONSTRAINT [FK_PrepperKit]
    FOREIGN KEY ([PrepperId])
    REFERENCES [dbo].[Preppers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PrepperKit'
CREATE INDEX [IX_FK_PrepperKit]
ON [dbo].[Kits]
    ([PrepperId]);
GO

-- Creating foreign key on [KitId] in table 'Items'
ALTER TABLE [dbo].[Items]
ADD CONSTRAINT [FK_KitItem]
    FOREIGN KEY ([KitId])
    REFERENCES [dbo].[Kits]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_KitItem'
CREATE INDEX [IX_FK_KitItem]
ON [dbo].[Items]
    ([KitId]);
GO

-- Creating foreign key on [ItemStatusId] in table 'Items'
ALTER TABLE [dbo].[Items]
ADD CONSTRAINT [FK_ItemStatusItem]
    FOREIGN KEY ([ItemStatusId])
    REFERENCES [dbo].[ItemStatus]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ItemStatusItem'
CREATE INDEX [IX_FK_ItemStatusItem]
ON [dbo].[Items]
    ([ItemStatusId]);
GO

-- Creating foreign key on [SampleKitId] in table 'SampleItems'
ALTER TABLE [dbo].[SampleItems]
ADD CONSTRAINT [FK_SampleKitSampleItem]
    FOREIGN KEY ([SampleKitId])
    REFERENCES [dbo].[SampleKits]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_SampleKitSampleItem'
CREATE INDEX [IX_FK_SampleKitSampleItem]
ON [dbo].[SampleItems]
    ([SampleKitId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------