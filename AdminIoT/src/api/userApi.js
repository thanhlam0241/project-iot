/* eslint-disable */
import axios from './axios'

const url = '/user'

class Api {
    getAll() {
        return axios.get(url)
    }
    getAllEmployee() {
        return axios.get(`${url}/employee`)
    }
    getAllManager() {
        return axios.get(`${url}/manager`)
    }
    getAllAdmin() {
        return axios.get(`${url}/admin`)
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
    updateProfile(id, data) {
        return axios.patch(`${url}/${id}/profile`, data)
    }
    delete(id) {
        return axios.delete(`${url}/${id}`)
    }
}

export default new Api()