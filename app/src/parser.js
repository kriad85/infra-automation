const fs = require('fs');
const YAML = require('js-yaml');

module.exports = (configs) => {
   console.log("processing parser...");
   let finalDef = '';
   const directoryPath = '../deployment/templates';
   fs.readdir(directoryPath, function (err, files) {
          //handling error
          if (err) {
                return console.log('Unable to scan directory: ' + err);
          } 
          //listing all files using forEach
          files.forEach(function (file) {
               // Do whatever you want to do with the file
               console.log(file.toString()); 
               let def = fs.readFileSync(directoryPath+'/'+file).toString();
               let curDef = '';
               configs.forEach((configItem) => {
	          for(opt in configItem) {
                     var keys = Object.keys(configItem[opt]);
                     curDef = def;
                     for (var i = 0; i < keys.length; i++) {
                        let key = keys[i];
                        let value = configItem[opt][keys[i]];
                        const re1 = new RegExp('@' + keys[i] + '@', 'g');
                        curDef = curDef.replace(re1, configItem[opt][keys[i]]);
                     }
                     console.log(curDef);
                     fs.writeFile('../deployment/output/'+file+'-'+opt, curDef, function (err) {
                          if (err) return console.log(err);
                          console.log('Generated ../deployment/output/'+file+'-'+opt);
                     });
                     
	          }
               });	
          });
   });
   	
  return finalDef
}

