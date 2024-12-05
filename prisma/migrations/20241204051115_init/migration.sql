/*
  Warnings:

  - You are about to drop the column `memberID` on the `borrows` table. All the data in the column will be lost.
  - You are about to drop the `members` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `userID` to the `Borrows` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `borrows` DROP FOREIGN KEY `Borrows_memberID_fkey`;

-- AlterTable
ALTER TABLE `borrows` DROP COLUMN `memberID`,
    ADD COLUMN `userID` INTEGER NOT NULL;

-- DropTable
DROP TABLE `members`;

-- CreateTable
CREATE TABLE `Users` (
    `userID` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `contact` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `profilePict` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`userID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Borrows` ADD CONSTRAINT `Borrows_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `Users`(`userID`) ON DELETE RESTRICT ON UPDATE CASCADE;
