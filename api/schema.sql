-- Music Bingo Schema

drop table if exists EventLog;
drop table if exists EventOptions;
drop table if exists PlaylistTracks;
drop table if exists Playlists;
drop table if exists Tracks;
drop table if exists Logins;
drop table if exists Devices;
drop table if exists Users;
drop table if exists Accounts;

create table Accounts (
  AccountId INT IDENTITY(1000,1) PRIMARY KEY,
  ContactName VARCHAR(255) NOT NULL,
  Company VARCHAR(255),
  PhoneNumber VARCHAR(255),
  Email VARCHAR(255),

  CreatedAt SMALLDATETIME NOT NULL DEFAULT GETUTCDATE(),
)

create table Users (
  Username VARCHAR(255) NOT NULL PRIMARY KEY,
  Password VARCHAR(255) NOT NULL,
  DisplayName VARCHAR(255) NOT NULL,
  PermissionScope VARCHAR(1000),

  AccountId INT foreign key references Accounts(AccountId) on delete cascade
);

create table Devices (
  DeviceId INT IDENTITY(1,1) PRIMARY KEY,
  Fingerprint VARCHAR(255),

  Username VARCHAR(255) NOT NULL foreign key references Users(Username) on delete cascade
);

create table Logins (
  LoginId INT IDENTITY(1,1) PRIMARY KEY,
  IpAddress VARCHAR(255),
  UserAgent VARCHAR(1000),
  CreatedAt SMALLDATETIME NOT NULL DEFAULT GETUTCDATE(),

  DeviceId INT NOT NULL foreign key references Devices(DeviceId)
);

create table Tracks (
  TrackId INT IDENTITY(1,1) PRIMARY KEY,
  Artist VARCHAR(255) NOT NULL,
  Title VARCHAR(255) NOT NULL,
  Hash VARCHAR(255) NOT NULL,
  IsNFF BIT NOT NULL DEFAULT 0,
  CreatedAt SMALLDATETIME NOT NULL DEFAULT GETUTCDATE(),

  AccountId INT foreign key references Accounts(AccountId),
);

create table Playlists (
  PlaylistId INT IDENTITY(1,1) PRIMARY KEY,
  Title VARCHAR(255) NOT NULL,
  IsDraft BIT NOT NULL DEFAULT 0,

  AccountId INT foreign key references Accounts(AccountId),
);

create table PlaylistTracks (
  PlaylistId INT NOT NULL foreign key references Playlists(PlaylistId),
  TrackId INT NOT NULL foreign key references Tracks(TrackId)
);

create table EventOptions (
  EventOptionId TINYINT NOT NULL PRIMARY KEY,
  Description VARCHAR(255) NOT NULL
);

create table EventLog (
  EventId INT IDENTITY(1,1) PRIMARY KEY,

  PlaylistId INT foreign key references Playlists(PlaylistId),
  TrackId INT foreign key references Tracks(TrackId),

  LoggedAt DATETIME NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETUTCDATE(),

  DeviceId INT NOT NULL foreign key references Devices(DeviceId),
  EventOptionsId TINYINT NOT NULL foreign key references EventOptions(EventOptionId),
);