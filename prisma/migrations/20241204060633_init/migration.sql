/*
  Warnings:

  - You are about to drop the `borrows` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `detailsofborrows` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[username]` on the table `Admins` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE `borrows` DROP FOREIGN KEY `Borrows_adminID_fkey`;

-- DropForeignKey
ALTER TABLE `borrows` DROP FOREIGN KEY `Borrows_userID_fkey`;

-- DropForeignKey
ALTER TABLE `detailsofborrows` DROP FOREIGN KEY `DetailsOfBorrows_borrowID_fkey`;

-- DropForeignKey
ALTER TABLE `detailsofborrows` DROP FOREIGN KEY `DetailsOfBorrows_inventoryID_fkey`;

-- DropTable
DROP TABLE `borrows`;

-- DropTable
DROP TABLE `detailsofborrows`;

-- CreateTable
CREATE TABLE `Borrow` (
    `borrowID` INTEGER NOT NULL AUTO_INCREMENT,
    `adminID` INTEGER NOT NULL,
    `userID` INTEGER NOT NULL,
    `date_of_borrow` DATETIME(3) NOT NULL,
    `date_of_return` DATETIME(3) NULL,
    `status` BOOLEAN NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`borrowID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DetailsOfBorrow` (
    `detailsID` INTEGER NOT NULL AUTO_INCREMENT,
    `borrowID` INTEGER NOT NULL,
    `inventoryID` INTEGER NOT NULL,
    `qty` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`detailsID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Admins_username_key` ON `Admins`(`username`);

-- AddForeignKey
ALTER TABLE `Borrow` ADD CONSTRAINT `Borrow_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `Users`(`userID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Borrow` ADD CONSTRAINT `Borrow_adminID_fkey` FOREIGN KEY (`adminID`) REFERENCES `Admins`(`adminID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DetailsOfBorrow` ADD CONSTRAINT `DetailsOfBorrow_borrowID_fkey` FOREIGN KEY (`borrowID`) REFERENCES `Borrow`(`borrowID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DetailsOfBorrow` ADD CONSTRAINT `DetailsOfBorrow_inventoryID_fkey` FOREIGN KEY (`inventoryID`) REFERENCES `Inventory`(`inventoryID`) ON DELETE RESTRICT ON UPDATE CASCADE;
