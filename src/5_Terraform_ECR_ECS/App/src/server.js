const express = require('express');
const app = express();

app.use(function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
});

// Hard-Coded for demo
const CONTACTS = [
                    {
                      "name": "Foo Bar",
                      "email": "foobar@test.com",
                      "cell": "555-123-4567"
                    },
                    {
                      "name": "Biz Baz",
                      "email": "bizbaz@test.com",
                      "cell": "555-123-5678"
                    },
                    {
                      "name": "Bing Bang",
                      "email": "bingbang@test.com",
                      "cell": "555-123-6789"
                    }
                ];

app.get('/contacts', (req, res) => {
  res.json({contacts: CONTACTS});
});

app.listen(3000, () =>{
   console.log('Server running on port 3000.'); 
});
