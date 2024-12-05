/*
  Warnings:

  - You are about to drop the `inventoryid` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `detailsofborrows` DROP FOREIGN KEY `DetailsOfBorrows_inventoryID_fkey`;

-- DropTable
DROP TABLE `inventoryid`;

-- CreateTable
CREATE TABLE `Inventory` (
    `inventoryID` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_item` VARCHAR(191) NOT NULL,
    `category` VARCHAR(191) NOT NULL,
    `location` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`inventoryID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `DetailsOfBorrows` ADD CONSTRAINT `DetailsOfBorrows_inventoryID_fkey` FOREIGN KEY (`inventoryID`) REFERENCES `Inventory`(`inventoryID`) ON DELETE RESTRICT ON UPDATE CASCADE;
