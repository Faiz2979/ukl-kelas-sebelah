/*
  Warnings:

  - You are about to drop the `_borrowtousers` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `admin` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `borrow` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `borrowdetail` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `inventory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_borrowtousers` DROP FOREIGN KEY `_borrowTousers_A_fkey`;

-- DropForeignKey
ALTER TABLE `_borrowtousers` DROP FOREIGN KEY `_borrowTousers_B_fkey`;

-- DropForeignKey
ALTER TABLE `borrow` DROP FOREIGN KEY `borrow_inventoryID_fkey`;

-- DropForeignKey
ALTER TABLE `borrowdetail` DROP FOREIGN KEY `borrowDetail_borrowID_fkey`;

-- DropTable
DROP TABLE `_borrowtousers`;

-- DropTable
DROP TABLE `admin`;

-- DropTable
DROP TABLE `borrow`;

-- DropTable
DROP TABLE `borrowdetail`;

-- DropTable
DROP TABLE `inventory`;

-- DropTable
DROP TABLE `users`;

-- CreateTable
CREATE TABLE `Members` (
    `memberID` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `contact` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `profilePict` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`memberID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Admins` (
    `adminID` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `contact` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `username` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`adminID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `InventoryID` (
    `bookID` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_item` VARCHAR(191) NOT NULL,
    `category` VARCHAR(191) NOT NULL,
    `location` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`bookID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Borrows` (
    `borrowID` INTEGER NOT NULL AUTO_INCREMENT,
    `memberID` INTEGER NOT NULL,
    `adminID` INTEGER NOT NULL,
    `date_of_borrow` DATETIME(3) NOT NULL,
    `date_of_return` DATETIME(3) NOT NULL,
    `status` BOOLEAN NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`borrowID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DetailsOfBorrows` (
    `detailsID` INTEGER NOT NULL AUTO_INCREMENT,
    `borrowID` INTEGER NOT NULL,
    `inventoryID` INTEGER NOT NULL,
    `qty` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`detailsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Borrows` ADD CONSTRAINT `Borrows_memberID_fkey` FOREIGN KEY (`memberID`) REFERENCES `Members`(`memberID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Borrows` ADD CONSTRAINT `Borrows_adminID_fkey` FOREIGN KEY (`adminID`) REFERENCES `Admins`(`adminID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DetailsOfBorrows` ADD CONSTRAINT `DetailsOfBorrows_borrowID_fkey` FOREIGN KEY (`borrowID`) REFERENCES `Borrows`(`borrowID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DetailsOfBorrows` ADD CONSTRAINT `DetailsOfBorrows_inventoryID_fkey` FOREIGN KEY (`inventoryID`) REFERENCES `InventoryID`(`bookID`) ON DELETE RESTRICT ON UPDATE CASCADE;
