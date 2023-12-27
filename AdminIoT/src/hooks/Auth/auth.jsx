import PropTypes from 'prop-types';
import { useNavigate } from "react-router-dom";
import { useState, useEffect, useContext, createContext } from "react";

const AuthContext = createContext();

const avatar = {
    ADMIN: '/assets/images/avatars/admin.jpg',
    MANAGER: '/assets/images/avatars/manager.png',
    EMPLOYEE: '/assets/images/avatars/employee.png',
}

const useAuthProvider = () => {
    const [auth, setAuth] = useState({
        username: '',
        fullname: '',
        role: 'ADMIN',
        avatar: avatar.ADMIN
    });
    const navigate = useNavigate()
    useEffect(() => {
        const user = {
            username: 'buitrongduc',
            fullname: 'Bui Trong Duc',
            identityCard: '033449232434',
            phone: '0334492324',
            role: 'ADMIN',
            avatar: avatar.ADMIN,
            email: 'buitrongduc@gmail.com',
            address: 'Ha Noi'
        }
        setAuth(user)
    }, [])
    useEffect(() => {
        // if (!auth.username) {
        //     navigate('/login')
        // }
    }, [auth, navigate])
    const login = async () => {
        const user = {
            username: 'buitrongduc',
            fullname: 'Bui Trong Duc',
            identityCard: '033449232434',
            phone: '0334492324',
            role: 'ADMIN',
            avatar: avatar.ADMIN,
            email: 'buitrongduc@gmail.com',
            address: 'Ha Noi'
        }
        setAuth(user)
    }
    const logout = async () => {
        setAuth(null)
    }
    return {
        login,
        logout,
        auth,
        setAuth
    }
}

const AuthProvider = ({ children }) => {
    /* Setting the initial state of the auth context. */
    const auth = useAuthProvider()

    return (
        <AuthContext.Provider value={auth}>
            {children}
        </AuthContext.Provider>
    )
}

export { AuthContext, AuthProvider }

export default function useAuth() {
    return useContext(AuthContext)
}

AuthProvider.propTypes = {
    children: PropTypes.node
}