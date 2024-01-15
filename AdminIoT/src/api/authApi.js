/* eslint-disable */
import axios from './axios'

const url = '/auth'

class Api {
    async login(username, password) {
        return axios.post(`${url}/authenticate-admin`, { username, password })
    }
    async changePassword(username, oldPassword, newPassword) {
        return axios.post(`${url}/change-password`, { username, oldPassword, newPassword })
    }
}

export default new Api()