CREATE DATABASE CinemaDB
GO

USE CinemaDB;

CREATE TABLE Genres
(
Id INT Identity(1,1) NOT NULL,
Name NVARCHAR(20) NOT NULL
CONSTRAINT PK_Genres_Id PRIMARY KEY (Id)
)
GO

CREATE TABLE Cinemas
(
Id int IDENTITY(1,1) NOT NULL,
Name NVARCHAR(20),
Address nvarchar(30),
CONSTRAINT PK_Cinemas_Id PRIMARY KEY (Id)
)
GO

CREATE TABLE Sessions
(
Id INT IDENTITY(1,1) NOT NULL,
Film_Name NVARCHAR(20) NOT NULL,
Session_Date DATE NOT NULL,
Session_Start TIME NOT NULL,
Session_End TIME NOT NULL,
CONSTRAINT PK_Sessions_Id PRIMARY KEY (Id)
)
GO

CREATE TABLE Films
(
Id INT IDENTITY(1,1) NOT NULL,
Producer NVARCHAR(20) NOT NULL,
DURATION TIME NOT NULL,
SessionId INT NOT NULL,
GenreId INT NOT NULL,
CONSTRAINT PK_Films_Id PRIMARY KEY (Id),
CONSTRAINT FK_Films_To_Sessions FOREIGN KEY (SessionId) REFERENCES Sessions (Id) ON DELETE CASCADE,
CONSTRAINT FK_Films_To_Genres FOREIGN KEY (GenreId) REFERENCES Genres (Id)
)
GO

CREATE TABLE Tickets
(
Id INT IDENTITY NOT NULL,
Price SMALLMONEY NOT NULL,
SessionId INT NOT NULL,
FilmID INT NOT NULL,
CONSTRAINT PK_Tickets_Id PRIMARY KEY (Id),
CONSTRAINT FK_Tickets_To_Sessions FOREIGN KEY (SessionId) REFERENCES Sessions (Id) ON DELETE CASCADE,
CONSTRAINT FK_Tickets_To_Films FOREIGN KEY (FilmId) REFERENCES Films (Id) ON DELETE NO ACTION,
CONSTRAINT CK_Tickets_Price CHECK (Price > 0)
)
GO

ALTER TABLE Sessions
ADD CinemaId INT NOT NULL
GO

ALTER TABLE Sessions
ADD FilmId INT NOT NULL
GO

ALTER TABLE Sessions
ADD CONSTRAINT FK_Sessions_To_Cinemas
FOREIGN KEY (CinemaId) REFERENCES Cinemas (Id)
GO

ALTER TABLE Sessions
ADD CONSTRAINT FK_Sessions_To_Films
FOREIGN KEY (FilmId) REFERENCES Films (Id)
GO

ALTER TABLE Sessions
ADD CONSTRAINT CK_Session_Session_End
CHECK (Session_End > Session_Start) 
GO



