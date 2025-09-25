/**
 * @file LoginStore.ets
 * @description
 * @author liushun
 * @created 2025/9/21 11:52
 * @lastModified 2025/9/21 11:52
 */

import {login} from "../service/index";

export default class LoginStore {

  async isLogin() {
    try {
      const res = await login({
        username: 'onedayago',
        password: '137212'
      })
      console.log(JSON.stringify(res))
    }catch (e) {
      console.log(e);
    }
  }

  async login() {
    try {
      const res = await login({
        username: 'onedayago',
        password: '137212'
      })
      if(res.data.id){
        return true;
      }
    }catch (e) {

    }
    return false;
  }
}
