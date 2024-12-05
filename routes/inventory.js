const express = require("express");
const {
    getInventory,
    getInventoryById,
    createInventory,
    updateInventory,
    borrowInventory,
    returnInventory,
    reportInventory,
    borrowAnalysis
} = require("../controllers/inventory.controller");
const router = express.Router();
const {authorize} = require('../controllers/auth.controller');

router.get("/", getInventory);
router.get("/:id", getInventoryById);
router.post("/",[authorize], createInventory);
router.put("/:id",[authorize], updateInventory);
router.post("/borrow",[authorize], borrowInventory);
router.post("/return",[authorize], returnInventory);
router.post("/usage-report",[authorize], reportInventory);
router.post("/borrow-analysis",[authorize], borrowAnalysis);

module.exports = router;
