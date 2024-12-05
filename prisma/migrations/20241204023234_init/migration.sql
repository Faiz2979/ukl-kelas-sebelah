/*
  Warnings:

  - You are about to drop the column `inventoryId` on the `borrow` table. All the data in the column will be lost.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `adminID` on the `users` table. All the data in the column will be lost.
  - Added the required column `adminID` to the `borrow` table without a default value. This is not possible if the table is not empty.
  - Added the required column `inventoryID` to the `borrow` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userID` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `_borrowtousers` DROP FOREIGN KEY `_borrowTousers_B_fkey`;

-- DropForeignKey
ALTER TABLE `borrow` DROP FOREIGN KEY `borrow_inventoryId_fkey`;

-- DropForeignKey
ALTER TABLE `borrowdetail` DROP FOREIGN KEY `borrowDetail_inventoryID_fkey`;

-- AlterTable
ALTER TABLE `borrow` DROP COLUMN `inventoryId`,
    ADD COLUMN `adminID` INTEGER NOT NULL,
    ADD COLUMN `inventoryID` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `users` DROP PRIMARY KEY,
    DROP COLUMN `adminID`,
    ADD COLUMN `userID` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`userID`);

-- AddForeignKey
ALTER TABLE `borrow` ADD CONSTRAINT `borrow_inventoryID_fkey` FOREIGN KEY (`inventoryID`) REFERENCES `inventory`(`inventoryID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_borrowTousers` ADD CONSTRAINT `_borrowTousers_B_fkey` FOREIGN KEY (`B`) REFERENCES `users`(`userID`) ON DELETE CASCADE ON UPDATE CASCADE;
