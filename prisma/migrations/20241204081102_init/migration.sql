/*
  Warnings:

  - The primary key for the `inventory` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `category` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `inventoryID` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `location` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `nama_item` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the `admins` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `borrow` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `detailsofborrow` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `id` to the `Inventory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Inventory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status` to the `Inventory` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `borrow` DROP FOREIGN KEY `Borrow_adminID_fkey`;

-- DropForeignKey
ALTER TABLE `borrow` DROP FOREIGN KEY `Borrow_userID_fkey`;

-- DropForeignKey
ALTER TABLE `detailsofborrow` DROP FOREIGN KEY `DetailsOfBorrow_borrowID_fkey`;

-- DropForeignKey
ALTER TABLE `detailsofborrow` DROP FOREIGN KEY `DetailsOfBorrow_inventoryID_fkey`;

-- AlterTable
ALTER TABLE `inventory` DROP PRIMARY KEY,
    DROP COLUMN `category`,
    DROP COLUMN `inventoryID`,
    DROP COLUMN `location`,
    DROP COLUMN `nama_item`,
    ADD COLUMN `description` VARCHAR(191) NULL,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `name` VARCHAR(191) NOT NULL,
    ADD COLUMN `status` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- DropTable
DROP TABLE `admins`;

-- DropTable
DROP TABLE `borrow`;

-- DropTable
DROP TABLE `detailsofborrow`;

-- DropTable
DROP TABLE `users`;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `User_username_key`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BorrowTransaction` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `inventoryId` INTEGER NOT NULL,
    `borrowDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `returnDate` DATETIME(3) NULL,
    `status` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `BorrowTransaction` ADD CONSTRAINT `BorrowTransaction_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BorrowTransaction` ADD CONSTRAINT `BorrowTransaction_inventoryId_fkey` FOREIGN KEY (`inventoryId`) REFERENCES `Inventory`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
