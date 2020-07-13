const configHelper = require('./config-loader');
const parse = require('./parser');
const fs = require('fs');

module.exports = () => {
  console.log("starting templater...");
  const configs = configHelper('app');
  if (configs.length > 0) {
    let resources = '';
    parse(configs);
  }
  return '';
};
