const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const inventoryModel = prisma.inventory;
const borrowTransactionModel = prisma.borrowTransaction;
const transactionLogModel = prisma.transactionLog;
const moment = require('moment');

// Mendapatkan daftar semua inventory
const getInventory = async (req, res) => {
    try {
        const inventory = await inventoryModel.findMany();
        res.status(200).json({
            status: true,
            message: "Inventory list",
            data: inventory,
        });
    } catch (error) {
        res.status(500).json({
            msg: error.message,
        });
    }
};

// Mendapatkan inventory berdasarkan ID
const getInventoryById = async (req, res) => {
    try {
        const { id } = req.params;
        const inventory = await inventoryModel.findUnique({
            where: { inventoryID: Number(id) }, // Disesuaikan dengan skema
        });

        if (!inventory) {
            return res.status(404).json({
                status: "error",
                message: "Inventory not found",
            });
        }

        const displayItem = {
            id: inventory.id,
            name: inventory.name,
            description: inventory.description,
            quantity: inventory.quantity,
            status: inventory.status,
        };

        res.status(200).json({
            status: "success",
            data: displayItem,
        });
    } catch (error) {
        res.status(500).json({
            status: "error",
            msg: error.message,
        });
    }
};

// Menambahkan inventory baru
const createInventory = async (req, res) => {
    const { nama_item, category,location, quantity } = req.body;
    try {
        const inventory = await inventoryModel.create({
            data: {
                nama_item,
                category,
                location,
                quantity,
                createdAt: new Date(),
                updatedAt: new Date(),
            },
        });
        
        const displayData = {
            id: inventory.inventoryID,
            nama_item,
            category,
            location,
            quantity,
        }
        res.status(201).json({
            status: "success",
            message: "Inventory added successfully",
            data: displayData,
        });
    } catch (error) {
        res.status(400).json({ msg: error.message });
    }
};

// Memperbarui inventory
const updateInventory = async (req, res) => {
    const { id } = req.params;
    const { name, category,location, quantity } = req.body;
    let displayItem = {
        id,
        name,
        category,
        location,
        quantity
    }
    try {
        const inventory = await inventoryModel.update({
            where: { inventoryID: Number(id) },
            data: {
                name,
                category,
                location,
                quantity,
                updatedAt: new Date(),
            },
        });

        res.status(200).json({
            status: "success",
            message: "Inventory updated successfully",
            data: displayItem,
        });
    } catch (error) {
        res.status(400).json({
            msg: error.message,
        });
    }
};

// Peminjaman barang
const borrowInventory = async (req, res) => {
    console.log("Request Body:", req.body); // Debugging untuk memastikan data diterima
    const { userID, inventoryID, borrowDate, returnDate } = req.body;

    // Validasi input
    if (!userID || !inventoryID || !borrowDate) {
        return res.status(400).json({
            userID,
            inventoryID,
            borrowDate,
            msg: "Missing required fields: userID, inventoryID, or borrowDate",
        });
    }
    try {
        // Simpan transaksi peminjaman
        const borrowTransaction = await borrowTransactionModel.create({
            data: {
                borrowDate: moment(borrowDate).toISOString(),
                returnDate: returnDate ? new Date(returnDate) : null,
                status: "borrowed",
                createdAt: new Date(),
                updatedAt: new Date(),
                user: { connect: { userID } },
                inventory: { connect: { inventoryID } },
            },
        });

        // Simpan log transaksi
        await transactionLogModel.create({
            data: {
                borrowID: borrowTransaction.borrowID,
                action: "BORROWED",
                userID,
                inventoryID,
                borrowDate: new Date(borrowDate),
                returnDate: returnDate ? new Date(returnDate) : null,
                status: "borrowed",
            },
        });

        let displayData = {
            borrowID: borrowTransaction.borrowID,
            userID,
            inventoryID,
            borrowDate: moment(borrowDate).format("YYYY-MM-DD"),
            returnDate: returnDate ? moment(returnDate).format("YYYY-MM-DD") : null,
        };

        res.status(201).json({
            status: "success",
            message: "Borrow transaction recorded successfully",
            data: displayData,
        });
    } catch (error) {
        res.status(500).json({
            msg: error.message,
        });
    }
};


const returnInventory = async (req, res) => {
    const { returnDate, borrowID } = req.body;

    try {
        // Update transaksi pengembalian
        const borrowTransaction = await borrowTransactionModel.update({
            where: { borrowID: Number(borrowID) },
            data: {
                returnDate: moment(returnDate).toISOString(),
                status: "returned",
                updatedAt: new Date(),
            },
        });
        statusLate = moment(returnDate).isAfter(borrowTransaction.returnDate) ? "late" : "returned";
        // Simpan log pengembalian
        await transactionLogModel.create({
            data: {
                borrowID: borrowTransaction.borrowID,
                action: "RETURNED",
                userID: borrowTransaction.userID,
                inventoryID: borrowTransaction.inventoryID,
                borrowDate: borrowTransaction.borrowDate,
                returnDate: borrowTransaction.returnDate,
                status: statusLate,
            },
        });

        let displayData = {
            borrowID,
            inventoryID: borrowTransaction.inventoryID,
            userID: borrowTransaction.userID,
            status: statusLate,
            actual_return_date: moment(returnDate).format("YYYY-MM-DD"),
        };

        res.status(200).json({
            status: "success",
            message: "Inventory returned successfully",
            data: displayData,
        });
    } catch (error) {
        res.status(500).json({
            msg: error.message,
        });
    }
};

const reportInventory = async (req, res) => {
    const { startDate, endDate, category, location } = req.body;

    let total_borrowed = 0;
    let total_returned = 0;
    let item_in_use = 0;

    try {
        // Query transaction logs dengan filter
        const transactionLogs = await prisma.transactionLog.findMany({
            where: {
                AND: [
                    {
                        timestamp: {
                            gte: new Date(startDate),
                            lte: new Date(endDate),
                        },
                    },
                    category
                        ? {
                            inventory: {
                                category: category,
                            },
                        }
                        : {},
                    location
                        ? {
                            inventory: {
                                location: location,
                            },
                        }
                        : {},
                ],
            },
            include: {
                inventory: true, // Include relasi inventory untuk akses kategori dan lokasi
            },
        });

        // Hitung total borrowed dan returned
        total_borrowed = transactionLogs.filter(
            (log) => log.action === "BORROWED"
        ).length;
        total_returned = transactionLogs.filter(
            (log) => log.action === "RETURNED"
        ).length;

        // Hitung item in use
        item_in_use = total_borrowed - total_returned;

        const displayData = {
            analysis_period: {
                start_date: moment(startDate).format("YYYY-MM-DD"),
                end_date: moment(endDate).format("YYYY-MM-DD"),
            },
            usage_analysis: {
                group: {
                    category,
                    location,
                },
                total_borrowed,
                total_returned,
                item_in_use,
            },
        };

        res.status(200).json({
            status: "success",
            message: "Inventory report",
            data: displayData,
        });
    } catch (error) {
        res.status(500).json({
            status: "error",
            message: error.message,
        });
    }
};

const borrowAnalysis = async (req, res) => {
    const { startDate, endDate } = req.body;

    try {
        // Query transaction logs untuk periode tertentu dengan aksi BORROWED
        const transactionLogs = await prisma.transactionLog.findMany({
            where: {
                AND: [
                    {
                        timestamp: {
                            gte: new Date(startDate),
                            lte: new Date(endDate),
                        },
                    },
                    {
                        action: "BORROWED",
                    },
                ],
            },
            include: {
                inventory: true, // Include inventory untuk kategori dan nama item
            },
        });

        // Hitung jumlah peminjaman per item
        const itemBorrowCount = transactionLogs.reduce((result, log) => {
            const itemId = log.inventoryID;
            if (!result[itemId]) {
                result[itemId] = {
                    item_id: itemId,
                    name: log.inventory.nama_item,
                    category: log.inventory.category,
                    total_borrowed: 0,
                };
            }
            result[itemId].total_borrowed++;
            return result;
        }, {});

        // Filter item yang sering dipinjam (frequently_borrowed_items)
        const frequentlyBorrowedItems = Object.values(itemBorrowCount)
            .sort((a, b) => b.total_borrowed - a.total_borrowed)
            .slice(0, 5); // Ambil top 5 item

        // Query untuk mengidentifikasi item yang tidak efisien (inefficient_items)
        const inefficientItemsQuery = await prisma.transactionLog.groupBy({
            by: ["inventoryID"],
            where: {
                AND: [
                    {
                        timestamp: {
                            gte: new Date(startDate),
                            lte: new Date(endDate),
                        },
                    },
                    {
                        status: "LATE",
                    },
                ],
            },
            _count: {
                inventoryID: true,
            },
        });

        const inefficientItems = inefficientItemsQuery.map((item) => {
            const inventory = transactionLogs.find(log => log.inventoryID === item.inventoryID)?.inventory;
            return {
                item_id: item.inventoryID,
                name: inventory.nama_item,
                category: inventory.category,
                total_borrowed: itemBorrowCount[item.inventoryID]?.total_borrowed || 0,
                total_late_returns: item._count.inventoryID,
            };
        });

        // Respons sesuai format
        const responseData = {
            status: "success",
            data: {
                analysis_period: {
                    start_date: startDate,
                    end_date: endDate,
                },
                frequently_borrowed_items: frequentlyBorrowedItems,
                inefficient_items: inefficientItems,
            },
        };

        res.json(responseData);
    } catch (error) {
        console.error(error);
        res.status(500).json({
            status: "error",
            message: "Internal Server Error",
        });
    }
};


module.exports = { 
    getInventory,
    getInventoryById,
    createInventory,
    updateInventory,
    borrowInventory,
    returnInventory,
    reportInventory,
    borrowAnalysis
};
