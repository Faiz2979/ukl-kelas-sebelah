const express = require('express');
const router = express();
router.use(express.json());

const { autenticate } = require('../controllers/auth.controller'); // Destructure the function from the object

router.post('/login', autenticate);

module.exports = router;
