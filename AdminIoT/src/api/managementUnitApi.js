/* eslint-disable */
import axios from './axios'

const url = '/management-unit'

class ManagementUnitApi {
    getAll() {
        return axios.get(url)
    }
    getById(id) {
        return axios.get(`${url}/${id}`)
    }
    create(data) {
        return axios.post(url, data)
    }
    update(id, data) {
        return axios.patch(`${url}/${id}`, data)
    }
    delete(id) {
        return axios.delete(`${url}/${id}`)
    }
    disableUser(id) {
        return axios.put(`${url}/user/disable/${id}`)
    }
    activeUser(id) {
        return axios.put(`${url}/user/active/${id}`)
    }
    createNewUser(id, data) {
        return axios.post(`${url}/${id}/user`, data)
    }
}

export default new ManagementUnitApi()