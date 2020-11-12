const express = require('express');
const router = express.Router();
const subjectController = require('../../controllers/subjects/subjects.controller');

router.get('/', subjectController.getSubject);


module.exports = router;