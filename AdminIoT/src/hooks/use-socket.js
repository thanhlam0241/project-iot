/* eslint-disable */
import { useRef } from 'react';
import { over } from 'stompjs';
import SockJS from 'sockjs-client';
import SERVER_URL from 'src/utils/resource'


const SOCKET_URL = `${SERVER_URL}/ws`;

function useSocket() {
    const stompClient = useRef(null);

    const connect = (onConnected, onError) => {
        const socket = new SockJS(SOCKET_URL);
        stompClient.current = over(socket);
        stompClient.current.connect({}, onConnected, onError);
    }

    const subscribe = (topic, onMessageReceived) => {
        stompClient.current.subscribe(topic, onMessageReceived);
    }

    const disconnect = () => {
        if (stompClient.current) {
            stompClient.current.disconnect();
        }
    }

    return {
        stompClient: stompClient.current,
        connect,
        subscribe,
        disconnect
    }
}

export default useSocket;