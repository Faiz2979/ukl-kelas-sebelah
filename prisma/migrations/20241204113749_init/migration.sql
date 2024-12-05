/*
  Warnings:

  - You are about to drop the column `inventoryId` on the `borrowtransaction` table. All the data in the column will be lost.
  - Added the required column `inventoryID` to the `BorrowTransaction` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `borrowtransaction` DROP FOREIGN KEY `BorrowTransaction_inventoryId_fkey`;

-- AlterTable
ALTER TABLE `borrowtransaction` DROP COLUMN `inventoryId`,
    ADD COLUMN `inventoryID` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `BorrowTransaction` ADD CONSTRAINT `BorrowTransaction_inventoryID_fkey` FOREIGN KEY (`inventoryID`) REFERENCES `Inventory`(`inventoryID`) ON DELETE RESTRICT ON UPDATE CASCADE;
