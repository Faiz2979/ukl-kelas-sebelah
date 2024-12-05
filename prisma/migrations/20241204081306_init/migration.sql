/*
  Warnings:

  - The primary key for the `inventory` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `description` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `inventory` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `inventory` table. All the data in the column will be lost.
  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `user` table. All the data in the column will be lost.
  - Added the required column `inventoryID` to the `Inventory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nama_item` to the `Inventory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userID` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `borrowtransaction` DROP FOREIGN KEY `BorrowTransaction_inventoryId_fkey`;

-- DropForeignKey
ALTER TABLE `borrowtransaction` DROP FOREIGN KEY `BorrowTransaction_userId_fkey`;

-- AlterTable
ALTER TABLE `inventory` DROP PRIMARY KEY,
    DROP COLUMN `description`,
    DROP COLUMN `id`,
    DROP COLUMN `name`,
    ADD COLUMN `category` VARCHAR(191) NULL,
    ADD COLUMN `inventoryID` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `nama_item` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`inventoryID`);

-- AlterTable
ALTER TABLE `user` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    ADD COLUMN `userID` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`userID`);

-- AddForeignKey
ALTER TABLE `BorrowTransaction` ADD CONSTRAINT `BorrowTransaction_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`userID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BorrowTransaction` ADD CONSTRAINT `BorrowTransaction_inventoryId_fkey` FOREIGN KEY (`inventoryId`) REFERENCES `Inventory`(`inventoryID`) ON DELETE RESTRICT ON UPDATE CASCADE;
