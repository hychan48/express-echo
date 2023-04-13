/**
yarn add mocha -D

package.json
  "imports": {
    "##/*": {
      "default": "./*"
    },
  },
  "type": "module",

  jsconfig.json
  {
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "##/*": ["./*"]
    }
  },
  "exclude": ["node_modules", ".nuxt", "dist"]
}



*/
// import { createRequire } from 'module';
// const require = createRequire(import.meta.url);
// const assert = require('assert');
// const {describe,it} = require('mocha');
import assert from 'node:assert';
import { describe, it} from 'mocha';
/*
1.
yarn add mocha @babel/polyfill @babel/register @babel/preset-env babel-plugin-module-resolver --dev
yarn add @babel/core --dev
2.
-r @babel/register -r babel-plugin-module-resolver

3.
.babelrc
{

  "presets": ["@babel/preset-env"],
  "plugins": [
    ["module-resolver", {
      "root": ["./src"],
      "alias": {
        "test": "./test",
        "underscore": "lodash",

        "~": "./"
      }
    }]
  ]

}
test specific timeout
this.timeout(500);//500ms
*/
/**
 * Should put this somewhere safe
 * todo filepath needs to be initialized as well...
 * @param fileName .json
 * @param data will automatically be changed
 */
import fs from 'node:fs';
import {stringify} from "node:querystring"
function writeToFile(fileName,data,space=2){
  const sFileName = /\./.test(fileName) ? fileName : fileName + '.json';
  const filePath = `dev/pbs/test/${sFileName}`
  fs.writeFileSync(filePath,
    typeof data === 'string' ? data :JSON.stringify(data,null,+space)
  );
}
import axios from 'axios'
describe('echo.test.mjs', function(){
  it('get localhost', async function(){
    //this.timeout(500);
    let out;
    const param = "hi";
    const expected = param;//i can think of some queries or param... let's just do param for now
    let url;
    // url = "http://localhost:3000/hi"
    // url = "http://localhost:3000"

    // url = "http://localhost:3000?param=hi"
    url = "http://localhost:3000?" + stringify({param})
    try{
      const oData = await axios.get(url);
      const {data} = oData;
      out = data;
      console.log(data);

    }catch (e) {
      if(e.code === 'ERR_BAD_REQUEST'){
        console.error('404 ERR_BAD_REQUEST')
      }else {
        console.error(e);
      }

    }finally {
      assert.strictEqual(out,expected);
    }

  });
});
