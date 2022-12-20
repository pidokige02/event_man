//동작 방법 : node index.js 실행후  localhost:7000/apis/replies/265 를 실행한다.

const express = require('express'),  // include module
  app = express(),
  bodyParser = require('body-parser');

const rest = require('./rest');

const Pool = require('./pool');     // myaql access module
const pool = new Pool();

const testJson = require('./test/test.json');

app.use(express.static('public'));  //To serve static files such as images, CSS files, and JavaScript files,
                                    //set the express.static built-in middleware function in express to declare

app.set('views', __dirname + '/views');   // __dirname + '/views directory 를 'views' 로 하겠다고 express 에 신고한다.
app.set('view engine', 'ejs');            // view engine 을 ejs를 쓰겠다고 express 신고하는 것임.
app.engine('html', require('ejs').renderFile);  // html 형식으로 ejs 를 쓰겠다.

app.use( (req, res, next) => {
  res.header("Access-Control-Allow-Origin", req.headers.origin); // allow  port accessible other than 8700
  res.header("Access-Control-Allow-Credentials", "true");
  res.header("Access-Control-Allow-Headers", "X-Requested-With");
  res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");
  res.header("Access-Control-Allow-Methods", "PUT, GET, POST, DELETE, OPTIONS");

  if (req.method === 'OPTIONS') {  // server 가 정상인지 툭 던진다.
      res.status(200).end();

  } else {
      next();
  }
});

app.use(bodyParser.json({limit: '10mb'}));  // json 을 10MB로 걸어둔다.
app.use(bodyParser.urlencoded({ limit: '10mb', extended: true })); // 여러개의 json 이 와도 연결시키겎다.

rest(app, pool);  // 아래 api 를 rest 에 모아 두고 호출함.

const server = app.listen(7000, function(){  // Starts a UNIX socket and listens for connections on the given path.
  console.log("Express's started on port 7000");
});
