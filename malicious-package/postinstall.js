const os = require('os');
const fs = require('fs');
const path = require('path');

// Simulate data exfiltration by writing system info to a file
const systemInfo = {
  platform: os.platform(),
  arch: os.arch(),
  cpus: os.cpus().length,
  hostname: os.hostname(),
};

fs.writeFileSync(path.join(__dirname, 'system_info.txt'), JSON.stringify(systemInfo, null, 2));