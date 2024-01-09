/* eslint-disable */
import React, { useState, useEffect, useRef } from 'react';
const SOCKET_URL = 'https://server-iot-tggk.onrender.com/ws';

import axios from 'src/api/axios'
import { over } from 'stompjs';
import SockJS from 'sockjs-client';

import { Button } from '@mui/material'

import sendPostRequest from 'src/utils/generateData.js';

// var stompClient = null;
function Socket() {
    const [message, setMessage] = useState('You server message here.');

    const websocket = new WebSocket("wss://server-iot-tggk.onrender.com/ws")

    // const [users, setUsers] = useState([]);
    // const [listMachines, setListMachines] = useState([]);

    // const [day, setDay] = useState(16);
    // const [month, setMonth] = useState(12);
    // const [year, setYear] = useState(2023);
    // const [shift, setShift] = useState('morning');
    // const [count, setCount] = useState(0);

    // const stompClient = useRef(null);

    useEffect(() => {
        if (websocket) {
            websocket.onopen = () => {
                console.log('connected')
            }
            websocket.onmessage = (e) => {
                console.log(e)
            }
            websocket.onclose = () => {
                console.log('disconnected')
            }
        }
    }, [websocket])

    // useEffect(() => {
    //     connect();
    // }, [stompClient.current])

    // const [isInterval, setIsInterval] = useState(false);

    // const fetchUsers = async () => {
    //     const response = await axios.get('/user/employee');
    //     if (response && response.data) {
    //         setUsers(response.data);
    //     }
    // }

    // const fetchMachines = async () => {
    //     const response = await axios.get('/attendance-machine');
    //     if (response && response.data) {
    //         setListMachines(response.data);
    //     }
    // }

    // useEffect(() => {
    //     fetchUsers();
    //     fetchMachines();
    // }, []);

    // useEffect(() => {
    //     if (isInterval) {
    //         seedDataUser()
    //     }
    // }, [users, listMachines, shift, day, month, year, isInterval])

    // const connect = () => {
    //     let Sock = new SockJS(SOCKET_URL);
    //     stompClient.current = over(Sock);
    //     stompClient.current.connect({}, onConnected, onError);
    // }

    // const onConnected = () => {
    //     stompClient.current.subscribe('/topic/message', onMessageReceived);
    // }

    // const onMessageReceived = (payload) => {
    //     var payloadData = JSON.parse(payload.body);
    //     console.log(payloadData)
    //     setMessage(payloadData.name);
    // }

    // const increase = () => {
    //     if (count === 10) {
    //         setIsInterval(false)
    //         return
    //     }
    //     if (shift === 'morning') {
    //         setShift('afternoon')
    //     }
    //     else {
    //         setShift('morning')
    //         if (day === 29) {
    //             setDay(1)
    //             if (month === 12) {
    //                 setMonth(1)
    //                 setYear(year + 1)
    //             } else {
    //                 setMonth(month + 1)
    //             }
    //         }
    //         else {
    //             setDay(day + 1)
    //         }
    //     }
    //     setCount(count + 1)
    // }

    const sendMessage = () => {
        // if (!stompClient.current) return;
        // var chatMessage = {
        //     name: 'Hello World'
        // };
        // stompClient.current.send("/app/sendMessage", {}, JSON.stringify(chatMessage));
        console.log(websocket)
        websocket.send("Hello World")
    }

    // const onError = (err) => {
    //     console.log(err);
    // }

    // const seedDataUser = () => {
    //     if (users.length > 0 && listMachines.length > 0) {
    //         sendPostRequest(users, listMachines, shift, day, month, year)
    //         setTimeout(() => {
    //             increase()
    //         }, 5000)
    //     }
    // }


    return (
        <div>
            <h1>
                {message}
            </h1>
            {/* <Button onClick={connect}>Connect</Button> */}
            <Button onClick={sendMessage}>Send message</Button>
            {/* <Button onClick={() => setIsInterval(true)}>Send message</Button> */}
        </div>
    );
}

export default Socket;