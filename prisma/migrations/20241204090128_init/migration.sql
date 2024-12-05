/*
  Warnings:

  - You are about to drop the column `userId` on the `borrowtransaction` table. All the data in the column will be lost.
  - Added the required column `userID` to the `BorrowTransaction` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `borrowtransaction` DROP FOREIGN KEY `BorrowTransaction_userId_fkey`;

-- AlterTable
ALTER TABLE `borrowtransaction` DROP COLUMN `userId`,
    ADD COLUMN `userID` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `BorrowTransaction` ADD CONSTRAINT `BorrowTransaction_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`userID`) ON DELETE RESTRICT ON UPDATE CASCADE;
