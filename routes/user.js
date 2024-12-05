const express = require("express");
const {
    getUsers,
    addUser,

} = require("../controllers/user.controller");
const router = express.Router();
const {authorize} = require('../controllers/auth.controller');

router.get("/",[authorize], getUsers);
router.post("/", addUser);

module.exports = router;