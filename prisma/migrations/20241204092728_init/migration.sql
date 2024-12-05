-- CreateTable
CREATE TABLE `TransactionLog` (
    `logID` INTEGER NOT NULL AUTO_INCREMENT,
    `borrowID` INTEGER NOT NULL,
    `userID` INTEGER NOT NULL,
    `inventoryID` INTEGER NOT NULL,
    `borrowDate` DATETIME(3) NOT NULL,
    `returnDate` DATETIME(3) NULL,
    `status` VARCHAR(191) NOT NULL,
    `action` VARCHAR(191) NOT NULL,
    `timestamp` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`logID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
