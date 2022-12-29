const Mydb = require('./mydb');

module.exports = function(app, pool) {  // class 는 아니고 utility 성 function 을 모아 둔것임

  // chrome 에서 localhost:7000 을 실행하면 Hello NodeJS!! 이 화면에 나타남.
  app.get(('/apis/'), (req, res) => {  // root 에서 요청이 오면 arrow function 안의 내용으로 반응한다.
    let mydb = new Mydb(pool);
    mydb.execute( conn => {
      conn.query("select COUNT(*) from Event", (err, ret) => {
        res.json(ret);
      });
    });
  });

// need to deal with '/events?_limit=' + perPage + '&_page=' + page'
  app.get('/apis/events/', (req, res) => {  // localhost:7000/apis/events/ 과 같이 request를 하면
    let mydb = new Mydb(pool);
    var limit = req.query._limit;
    var page = req.query._page;
    var offset = limit*(page-1);

    // comment out to make totalcount for header
    var totalcount;

    mydb.execute( conn => {
      conn.query("select COUNT(*) from Event2", (err, ret) => {
        totalcount = ret;
        console.log("totalcount",totalcount);
      });
    });

    mydb.execute( conn => {
      const sql = `select * from Event2 LIMIT ${offset} , ${limit}`
      // below code doesn't work so commented out
      // conn.query("select * from Event LIMIT ? , ?", [offset, limit], (err, ret) => {
      conn.query(sql,(err, ret) => {
        // console.log("toString",totalcount['COUNT(*)'].value)
        // res.append("x-total-count","10")
        // res.append('Warning', '199 Miscellaneous warning')
        // res.setHeader('Access-Control-Expose-Headers', 'Location')
        // res.setHeader('X-Total-Count', 6)

        console.log(ret);
        res.json(ret);
      });
    });
  });


  app.get('/apis/events/:id', (req, res) => {
    let id = req.params.id;

    let mydb = new Mydb(pool);
    mydb.execute( conn => {
      conn.query("select * from Event2 where event_id=?", [id], (err, ret) => {
        res.json(ret[0]);
        console.log("/apis/events/:id",ret[0]);
      });
    });
  });

  app.post(('/apis/events'), (req, res) => {   // localhost:7000/test/aaa@ddd.com 과 같이 request를 하면
    let event_id = req.body.id;
    let title = req.body.title;
    let date = new Date(req.body.date);
    // date 로 뱐수 변환을 하지 않으면 문제가 생긴다.
    let time = req.body.time;
    let location = req.body.location;
    let description = req.body.description;
    let organizer = req.body.organizer.name;
    let category = req.body.category;
    // comment out below due to not using precreated sql command
    //const sql = `insert into Event(title, location, description, organizer, category) value( "${title}", "${location}", "${description}", "${organizer}", "${category}" )`;

    let mydb = new Mydb(pool);
    // mydb.executeTx( conn => {  // comment out due to not working
    mydb.execute( conn => {
    conn.query("insert into Event2(event_id, title, date, time, location, description, organizer, category) value(?, ?, ?, ?, ?, ?, ?, ?)",
      [event_id, title, date, time, location, description, organizer, category], (err, ret) => {
      // comment out below due to not using precreated sql command
      //conn.query(sql,(err, ret) => {
        if(err) throw err;
        res.json(ret.affectedRows);
      });
    });
  });
};