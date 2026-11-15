USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ShoppingServiceMVC')
BEGIN
    CREATE DATABASE ShoppingServiceMVC;
END
GO

USE ShoppingServiceMVC;
GO

-- 1. Bảng [User] phục vụ Đăng nhập, Đăng ký, Phân quyền (JPA Entity User)
IF OBJECT_ID('dbo.[User]', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.[User](
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [email] NVARCHAR(255) NOT NULL,
        [username] NVARCHAR(50) NOT NULL UNIQUE,
        [fullname] NVARCHAR(100) NOT NULL,
        [password] NVARCHAR(100) NOT NULL,
        [avatar] NVARCHAR(255) NULL,
        [roleid] INT NOT NULL DEFAULT 3, -- 1: Admin, 2: Manager, 3: User
        [phone] NVARCHAR(20) NULL,
        [createdDate] DATE NULL
    );
END
GO

-- 2. Bảng categories phục vụ CRUD JPA (JPA Entity Category)
IF OBJECT_ID('dbo.categories', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.categories(
        [categoryId] INT IDENTITY(1,1) PRIMARY KEY,
        [categoryname] NVARCHAR(255) NOT NULL,
        [images] NVARCHAR(500) NULL,
        [status] INT NOT NULL DEFAULT 1 -- 1: Hoạt động, 0: Khóa
    );
END
GO

-- 3. Bảng videos có quan hệ 1-N với categories (JPA Entity Video)
IF OBJECT_ID('dbo.videos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.videos(
        [videoId] NVARCHAR(50) PRIMARY KEY,
        [active] BIT NOT NULL DEFAULT 1,
        [description] NVARCHAR(MAX) NULL,
        [poster] NVARCHAR(500) NULL,
        [title] NVARCHAR(255) NULL,
        [views] INT NOT NULL DEFAULT 0,
        [categoryId] INT FOREIGN KEY REFERENCES dbo.categories([categoryId]) ON DELETE CASCADE
    );
END
GO

-- 4. Dữ liệu mẫu cho sinh viên Trần Hữu Việt Huân
-- Tài khoản Admin
IF NOT EXISTS (SELECT 1 FROM dbo.[User] WHERE [username] = 'admin')
BEGIN
    INSERT INTO dbo.[User] ([email], [username], [fullname], [password], [avatar], [roleid], [phone], [createdDate])
    VALUES (N'admin@gmail.com', N'admin', N'Trần Hữu Việt Huân', N'123456', NULL, 1, N'0901234567', GETDATE());
END
ELSE
BEGIN
    UPDATE dbo.[User] 
    SET [fullname] = N'Trần Hữu Việt Huân', [password] = N'123456', [roleid] = 1 
    WHERE [username] = 'admin';
END

IF NOT EXISTS (SELECT 1 FROM dbo.[User] WHERE [username] = 'viethuan')
BEGIN
    INSERT INTO dbo.[User] ([email], [username], [fullname], [password], [avatar], [roleid], [phone], [createdDate])
    VALUES (N'viethuan@hcmute.edu.vn', N'viethuan', N'Trần Hữu Việt Huân', N'123456', NULL, 1, N'0908617108', GETDATE());
END
ELSE
BEGIN
    UPDATE dbo.[User] 
    SET [fullname] = N'Trần Hữu Việt Huân', [password] = N'123456', [roleid] = 1 
    WHERE [username] = 'viethuan';
END
GO

-- Dữ liệu mẫu danh mục JPA
IF NOT EXISTS (SELECT 1 FROM dbo.categories WHERE [categoryname] = N'Điện thoại & Phụ kiện')
BEGIN
    INSERT INTO dbo.categories ([categoryname], [images], [status])
    VALUES 
    (N'Điện thoại & Phụ kiện', N'https://via.placeholder.com/200x150?text=Phone', 1),
    (N'Laptop & Thiết bị số', N'https://via.placeholder.com/200x150?text=Laptop', 1),
    (N'Thời trang & Làm đẹp', N'avatar.png', 1);
END
GO

SELECT * FROM dbo.[User];
SELECT * FROM dbo.categories;
SELECT * FROM dbo.videos;
GO
