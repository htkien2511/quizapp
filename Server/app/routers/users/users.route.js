const express = require('express');
const router = express.Router();
const userController = require('../../controllers/users/users.controller');

router.get('/', userController.getUsers);
router.get('/completed-subject', userController.getCompletedSubject)
router.post('/completed-subject', userController.postCompletedSubject)
router.get('/subject', userController.getSubjectByUser)
router.post('/subject', userController.postSubjectByUser)
router.post('/check-login', userController.checkLogin)

module.exports = router;