/* eslint-disable  */

import * as React from 'react';
import Paper from '@mui/material/Paper';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';

import Iconify from 'src/components/iconify';
import userApi from 'src/api/userApi';
import EmployeeForm from './employee-form';
import { useSnackbar } from 'notistack';
import { Backdrop } from 'src/components/backdrop';

import RegisterForm from './register/register-form'
import managementUnitApi from 'src/api/managementUnitApi';

import { over } from 'stompjs';
import SockJS from 'sockjs-client';
import SOCKET_URL from 'src/utils/resource';

const columns = [
    { id: 'stt', label: 'STT', minWidth: 100 },
    { id: 'code', label: 'Mã NV', minWidth: 100 },
    { id: 'fullName', label: 'Tên NV', minWidth: 100 },
    { id: 'managementUnit', label: 'Phòng ban', minWidth: 100 },
    { id: 'phone', label: 'Số điện thoại', minWidth: 100 },
    { id: 'address', label: 'Địa chỉ', minWidth: 100 },
];

export default function StickyHeadTable() {
    const [page, setPage] = React.useState(0);
    const [rowsPerPage, setRowsPerPage] = React.useState(5);

    const [loading, setLoading] = React.useState(false);

    const [employees, setEmployees] = React.useState([]);

    const [openForm, setOpenForm] = React.useState(false);

    const [openRegisterForm, setOpenRegisterForm] = React.useState(false);

    const [managemaentUnits, setManagementUnits] = React.useState([]);

    const [messageRegister, setMessageRegister] = React.useState('Đang xử lý. Vui lòng đợi giây lát.');

    const stompClient = React.useRef(null);

    React.useEffect(() => {
        connect();
    }, [stompClient.current])

    const connect = () => {
        let Sock = new SockJS(SOCKET_URL + '/ws');
        stompClient.current = over(Sock);
        stompClient.current.connect({}, onConnected, onError);
    }

    const onConnected = () => {
        stompClient.current.subscribe('/topic/register', onMessageReceived);
    }

    const onMessageReceived = (payload) => {
        var payloadData = JSON.parse(payload.body);
        let isSuccess = payloadData.success ? true : false;
        if (isSuccess) {
            setMessageRegister('Đăng ký thành công');
        } else {
            setMessageRegister('Đăng ký thất bại');
        }
    }

    const onError = (err) => {
        console.log(err);
    }

    React.useEffect(() => {
        fetchEmployees();
        fetchManagementUnits();
    }, []);

    const fetchManagementUnits = async () => {
        try {
            const response = await managementUnitApi.getAll();
            setManagementUnits(response.data);
        } catch (error) {
            console.log('Failed to fetch management units: ', error);
        }
    }

    const fetchEmployees = async () => {
        try {
            setLoading(true);
            const response = await userApi.getAllEmployee();
            setEmployees(response.data.map((employee, index) => {
                return {
                    ...employee,
                    stt: index + 1,
                    managementUnit: employee.managementUnit ? employee.managementUnit.name : ''
                }
            }));
            console.log(response);
        } catch (error) {
            console.log('Failed to fetch employee: ', error);
        } finally {
            setLoading(false);
        }
    }

    const handleOpenForm = () => {
        setOpenForm(true);
    };

    const handleCloseForm = () => {
        setOpenForm(false);
    };

    const handleOpenRegisterForm = () => {
        setOpenRegisterForm(true);
    };

    const handleCloseRegisterForm = () => {
        setOpenRegisterForm(false);
    }

    const handleChangePage = (event, newPage) => {
        setPage(newPage);
    };

    const handleChangeRowsPerPage = (event) => {
        setRowsPerPage(+event.target.value);
        setPage(0);
    };

    return (
        <Paper sx={{ width: '100%', overflow: 'auto' }}>
            {openForm && <EmployeeForm open={openForm} handleClose={handleCloseForm} />}
            {openRegisterForm && <RegisterForm
                open={openRegisterForm}
                handleClose={handleCloseRegisterForm}
                listUnit={managemaentUnits}
                message={messageRegister}
            />}
            <Backdrop open={loading} />
            <Stack direction="row" alignItems="center" justifyContent="space-between" mb={5}>
                <Typography variant="h4">Danh sách nhân viên</Typography>

                <Button onClick={handleOpenRegisterForm} variant="contained" color="inherit" startIcon={<Iconify icon="eva:plus-fill" />}>
                    Tạo mới
                </Button>
            </Stack>
            <TableContainer sx={{ overflow: 'auto', height: '450px' }} >
                <Table stickyHeader aria-label="sticky table">
                    <TableHead>
                        <TableRow>
                            {columns.map((column) => (
                                <TableCell
                                    key={column.id}
                                    align={column.align}
                                    style={{ minWidth: column.minWidth }}
                                >
                                    {column.label}
                                </TableCell>
                            ))}
                            <TableCell align="right">Thao tác</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {employees.length > 0 && employees
                            .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                            .map((row) => {
                                return (
                                    <TableRow hover role="checkbox" tabIndex={-1} key={row.code}>
                                        {columns.map((column) => {
                                            const value = row[column.id];
                                            return (
                                                <TableCell key={column.id} align={column.align}>
                                                    {column.format && typeof value === 'number'
                                                        ? column.format(value)
                                                        : value}
                                                </TableCell>
                                            );
                                        })}
                                        <TableCell align="right">
                                            <Button onClick={handleOpenForm} sx={{ marginRight: 2 }} variant="contained" color="inherit" startIcon={<Iconify icon="eva:edit-2-fill" />}>
                                                Sửa
                                            </Button>
                                            {/* <Button onClick={() => deleteEmployee(row.id)} variant="contained" color="error" startIcon={<Iconify icon="eva:trash-fill" />}>
                                                Xóa
                                            </Button> */}
                                        </TableCell>
                                    </TableRow>
                                );
                            })}
                    </TableBody>
                </Table>
            </TableContainer>
            <TablePagination
                rowsPerPageOptions={[5, 20, 100]}
                component="div"
                count={employees.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onPageChange={handleChangePage}
                onRowsPerPageChange={handleChangeRowsPerPage}
            />
        </Paper>
    );
}
