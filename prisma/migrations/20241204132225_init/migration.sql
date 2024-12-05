-- AddForeignKey
ALTER TABLE `TransactionLog` ADD CONSTRAINT `TransactionLog_inventoryID_fkey` FOREIGN KEY (`inventoryID`) REFERENCES `Inventory`(`inventoryID`) ON DELETE RESTRICT ON UPDATE CASCADE;
