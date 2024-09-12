const express = require('express');
const cors = require('cors');
const app = express();

const cors = require('cors');
app.use(cors({
  origin: 'http://localhost:64570/'
}));


app.use(cors());
app.use(express.json());

app.use('/', (req, res) => {
  const url = req.query.url;
  if (!url) {
    return res.status(400).send('Missing URL');
  }


  require('request')(url, (error, response, body) => {
    if (error) {
      return res.status(500).send(error);
    }
    res.send(body);
  });
});

app.listen(3030, () => {
  console.log('CORS proxy server is running on port 3030');
});




<script>
  window.addEventListener('load', function(ev) {
    let serviceWorkerVersion = '{{flutter_service_worker_version}}';
    // your existing code
  });




///n
  FlutterLoader.load().then(function(engineInitializer) {
    return engineInitializer.initializeEngine();
  }).then(function(appRunner) {
    return appRunner.runApp();
  });
</script>
