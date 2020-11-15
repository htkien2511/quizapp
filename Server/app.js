let express = require('express');
let bodyParser = require('body-parser')
let app = express();
let port = process.env.PORT || 5000;

// Router
const subjectsRouter = require('./app/routers/subjects/subjects.route');
const usersRouter = require('./app/routers/users/users.route');

//Thiết lập kết nối tới Mongoose
var mongoose = require('mongoose');
var mongoDB = 'mongodb+srv://admin:admin@cluster0.pyu1n.mongodb.net/quizapp?retryWrites=true&w=majority';
mongoose.connect(mongoDB, {useNewUrlParser: true,  useUnifiedTopology: true }, () => {
    console.log("Connect to mongodb success");
});


// Welcome message
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))
app.get('/', (req, res) => res.send('Welcome to Express'));
app.use('/subject', subjectsRouter)
app.use('/user', usersRouter)

// Launch app to the specified port
app.listen(port, function() {
    console.log("Running FirstRest on Port "+ port);
})

