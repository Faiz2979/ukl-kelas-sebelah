/*
  Warnings:

  - The primary key for the `borrowtransaction` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `borrowtransaction` table. All the data in the column will be lost.
  - Added the required column `borrowID` to the `BorrowTransaction` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `borrowtransaction` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    ADD COLUMN `borrowID` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`borrowID`);
