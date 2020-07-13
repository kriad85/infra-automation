const fs = require('fs');

module.exports = (configFileName) => {
    console.log("processing config file...");
    
    configFile = (`../config/${configFileName}.json`);   
    
    let configs = [];
    if (fs.existsSync(configFile)) {
      configs = JSON.parse(fs.readFileSync(configFile));       
    }
    return configs;
};
