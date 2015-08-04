USE [BPrep]
GO

SET IDENTITY_INSERT [dbo].[Parameters] ON 
GO
INSERT [dbo].[Parameters] ([Id], [Name], [Value]) VALUES (1, N'TotalAdsOnScreen', N'4') 
INSERT [dbo].[Parameters] ([Id], [Name], [Value]) VALUES (2, N'AdminEmailAddress', N'admin@bPrep.net') 
INSERT [dbo].[Parameters] ([Id], [Name], [Value]) VALUES (3, N'LastDailyEmailsSent', N'') 
INSERT [dbo].[Parameters] ([Id], [Name], [Value]) VALUES (4, N'LastWeeklyEmailsSent', N'') 
GO
SET IDENTITY_INSERT [dbo].[Parameters] OFF 
GO


--ItemStatus START
SET IDENTITY_INSERT [dbo].[ItemStatus] ON 
GO
INSERT [dbo].[ItemStatus] ([Id], [Name]) VALUES (1, N'Planned') 
GO
INSERT [dbo].[ItemStatus] ([Id], [Name]) VALUES (2, N'Ordered') 
GO
INSERT [dbo].[ItemStatus] ([Id], [Name]) VALUES (3, N'Received') 
GO
INSERT [dbo].[ItemStatus] ([Id], [Name]) VALUES (4, N'Positioned') 
GO
SET IDENTITY_INSERT [dbo].[ItemStatus] OFF 
GO
--ItemStatus END

--SampleKits START
SET IDENTITY_INSERT [dbo].[SampleKits] ON 
GO
INSERT [dbo].[SampleKits] ([Id], [Name]) VALUES (1, N'Car GHB') 
GO
INSERT [dbo].[SampleKits] ([Id], [Name]) VALUES (2, N'Work GHB') 
GO
INSERT [dbo].[SampleKits] ([Id], [Name]) VALUES (3, N'Everyday Carry Kit') 
GO
SET IDENTITY_INSERT [dbo].[SampleKits] OFF 
GO
--SampleKits END

--Sample Items START
SET IDENTITY_INSERT [dbo].[SampleItems] ON 

GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (1, N'Blanket', 1, 1, 0, 0, N'Great if you need to wait for breakdown or get stuck in long jam', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Fe8294053-b387-4513-9b7a-e1a2954908a3"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Fe8294053-b387-4513-9b7a-e1a2954908a3&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (2, N'Compass', 1, 1, 0, 0, N'Peace of mind that you are still heading in the right direction', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Fe2b6c88d-ca2f-487d-af6a-15cba88077c3"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Fe2b6c88d-ca2f-487d-af6a-15cba88077c3&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (3, N'Musli Bars', 6, 1, 90, 7, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (4, N'Water (ltrs)', 1, 1, 30, 7, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (5, N'Fleece', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (6, N'Gloves (pair)', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (9, N'Hot Chocolate sachets', 2, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (11, N'Purification tablets', 10, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (13, N'Hat', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (15, N'Lighter', 2, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (16, N'Matches', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (17, N'Wire saw', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (18, N'Compression bandage', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (19, N'Steri strips', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (20, N'tweezers', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (21, N'elastoplasts', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (22, N'blister plasters', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (23, N'antibiotic ointment', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (24, N'Wipes', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (25, N'Hand sanitiser', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (26, N'towel', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (27, N'BW Key', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (28, N'Torch', 1, 2, 0, 0, N'', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F9a60ea95-fd2c-4f44-9618-26ba01e3bf2b"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F9a60ea95-fd2c-4f44-9618-26ba01e3bf2b&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (29, N'Change for payphone', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (30, N'Whistle', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (31, N'Route in GPS', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (32, N'Simpified route print out', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (33, N'BW facilities map', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (34, N'Zip ties', 1, 2, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (35, N'Keyring Torch', 1, 3, 0, 0, N'Those tiny LED lights. Suprisingly powerful.', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F69d3b6de-b002-4f3f-b80d-bc8160b5bb16"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F69d3b6de-b002-4f3f-b80d-bc8160b5bb16&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (36, N'Pocket Torch', 1, 3, 0, 0, N'Powerful but need to be carried in a pocket or bag', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Ff1f2a635-35f5-4d37-8b62-724d491b512f"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Ff1f2a635-35f5-4d37-8b62-724d491b512f&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (37, N'Small Compass', 1, 3, 0, 0, N'', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F9195191f-454f-4d7e-9f98-cc10c54e4613"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F9195191f-454f-4d7e-9f98-cc10c54e4613&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (38, N'Multitool (small or regular)', 1, 3, 0, 0, N'', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F14d7e393-8982-405c-8c55-92f76f0b543c"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F14d7e393-8982-405c-8c55-92f76f0b543c&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (39, N'Fresnel Lens', 1, 3, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (45, N'Duck Tape', 1, 3, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (46, N'Zip Ties', 2, 3, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (47, N'Cordage', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (48, N'Duck Tape', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (49, N'First Aid kit', 1, 1, 0, 0, N'', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Fcc8aa0ce-4611-495b-95a4-ed0473787ddb"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Fcc8aa0ce-4611-495b-95a4-ed0473787ddb&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (50, N'Bandana', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (51, N'Sun Screen', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (52, N'Road Atlas', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (53, N'Solar Charger', 1, 1, 0, 0, N'', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F5db9d3db-c2e4-444e-b8e0-c39d5df98533"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F5db9d3db-c2e4-444e-b8e0-c39d5df98533&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (55, N'Small Binoculars', 1, 1, 0, 0, N'', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Fe65dcf07-e882-498b-a0ee-70f443fa4082"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2Fe65dcf07-e882-498b-a0ee-70f443fa4082&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (56, N'Nalgene Bottle', 1, 1, 0, 0, N'', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F1627d4a2-ef46-452c-a1b2-40f85713c642"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F1627d4a2-ef46-452c-a1b2-40f85713c642&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (57, N'Cup (fits over bottle)', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (58, N'Water Purification Tablets', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (59, N'Socking Hat', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (60, N'Bin bags', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (61, N'Head Torch', 1, 1, 0, 0, N'', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F4e9b6cf2-35fd-462e-896a-3736c883f236"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F4e9b6cf2-35fd-462e-896a-3736c883f236&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (62, N'Hand Cranked Torch', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (63, N'Multi Tool', 1, 1, 0, 0, N'', N'<SCRIPT charset="utf-8" type="text/javascript" src="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F67143e5a-a803-4735-a453-c764163f510f"> </SCRIPT> <NOSCRIPT><A HREF="http://ws-eu.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&MarketPlace=GB&ID=V20070822%2FGB%2Fbprenet-21%2F8001%2F67143e5a-a803-4735-a453-c764163f510f&Operation=NoScript">Amazon.co.uk Widgets</A></NOSCRIPT>')
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (64, N'Emergency Blankets', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (65, N'Jump Leads', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (66, N'Spare Tyre', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (67, N'Jack', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (68, N'Tyre Wrench', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (69, N'Boots', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (71, N'Warm Clothes', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (72, N'Toilet paper', 1, 1, 0, 0, N'', NULL)
GO
INSERT [dbo].[SampleItems] ([Id], [Name], [Quantity], [SampleKitId], [DaysShelfLife], [DaysWarningOfReplacement], [Description], [AmazonWidget]) VALUES (74, N'Multitool', 1, 1, 0, 0, N'', NULL)
GO
SET IDENTITY_INSERT [dbo].[SampleItems] OFF
GO
--Sample Items END