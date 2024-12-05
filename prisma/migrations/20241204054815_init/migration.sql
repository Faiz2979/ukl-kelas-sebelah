/*
  Warnings:

  - You are about to drop the column `address` on the `admins` table. All the data in the column will be lost.
  - You are about to drop the column `contact` on the `admins` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `admins` DROP COLUMN `address`,
    DROP COLUMN `contact`;
