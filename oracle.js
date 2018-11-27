const oracledb = require('oracledb'),
  config = require('./config');

const oracle = function(query){
  return new Promise(resolve => {
    oracledb.getConnection(
    {
      user          : config.user,
      password      : config.password,
      connectString : config.connectString
    },
    function(err, connection) {
      if (err) {
        console.error(err.message);
        return;
      }
      connection.execute(
        query,
        function(err, result) {
          if (err) {
            // return error message
            resolve(err.message);
            doRelease(connection);
            return;
          }
          // return result;
          resolve(result);
          doRelease(connection);
        });
    });

    function doRelease(connection) {
      connection.close(
        function(err) {
          if (err)
            console.error(err.message);
        });
      }
  })
}


module.exports = oracle;