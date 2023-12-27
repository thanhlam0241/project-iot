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

import { useSnackbar } from 'notistack';
import { Backdrop } from 'src/components/backdrop';

import Iconify from 'src/components/iconify';

import DepartmentForm from './department-form';
import managementUnitApi from 'src/api/managementUnitApi';

const columns = [
    { id: 'stt', label: 'STT', minWidth: 100 },
    { id: 'code', label: 'Mã', minWidth: 100 },
    { id: 'name', label: 'Tên', minWidth: 100 },
    // {
    //     id: 'density',
    //     label: 'Density',
    //     minWidth: 170,
    //     align: 'right',
    //     format: (value) => value.toFixed(2),
    // },
];


export default function StickyHeadTable() {
    const [page, setPage] = React.useState(0);
    const [rowsPerPage, setRowsPerPage] = React.useState(5);

    const [loading, setLoading] = React.useState(false);

    const { enqueueSnackbar } = useSnackbar();

    const [openForm, setOpenForm] = React.useState(false);

    const [managementUnits, setManagementUnits] = React.useState([]);

    const [setupForm, setSetupForm] = React.useState({
        type: 'ADD',
        data: null
    });

    React.useEffect(() => {
        fetchManagementUnits();
    }, []);

    const handleOpenForm = () => {
        setOpenForm(true);
    };

    const resetScreen = () => {
        setSetupForm({
            type: 'ADD',
            data: null
        });

        fetchManagementUnits();
    }

    const fetchManagementUnits = async () => {
        try {
            setLoading(true);
            const response = await managementUnitApi.getAll();
            setManagementUnits(response.data.map((managementUnit, index) => {
                return {
                    ...managementUnit,
                    stt: index + 1
                }
            }));
            console.log(response);
        } catch (error) {
            console.log('Failed to fetch management units: ', error);
        } finally {
            setLoading(false);
        }
    }

    const updateManagementUnit = async (id, managementUnit) => {
        try {
            setLoading(true);
            const response = await managementUnitApi.update(id, managementUnit);
            console.log(response);
            enqueueSnackbar("Cập nhật thành công", { variant: 'success' })
            resetScreen()
        } catch (error) {
            console.log('Failed to update management unit: ', error);
        } finally {
            setLoading(false);
        }
    }

    const addManagementUnit = async (managementUnit) => {
        try {
            setLoading(true);
            const response = await managementUnitApi.create(managementUnit);
            console.log(response);
            enqueueSnackbar("Tạo mới thành công", { variant: 'success' })
            resetScreen()
        } catch (error) {
            console.log('Failed to add management unit: ', error);
        } finally {
            setLoading(false);
        }
    }

    const deleteManagementUnit = async (id) => {
        try {
            const response = await managementUnitApi.delete(id);
            console.log(response);
            enqueueSnackbar("Xóa thành công", { variant: 'success' })
            resetScreen()
        } catch (error) {
            console.log('Failed to delete management unit: ', error);
        }
    }

    const handleActionForm = (action, data) => {
        const dataForm = { code: data.code, name: data.name }
        switch (action) {
            case 'add':
                addManagementUnit(dataForm);
                break;
            case 'update':
                updateManagementUnit(data.id, dataForm);
                break;
            default:
                break;
        }
        handleCloseForm();
    }

    const onClickDetail = (data) => {
        console.log(data)
        setSetupForm({
            type: 'UPDATE',
            data: data
        });
        setOpenForm(true);
    }

    const handleCloseForm = () => {
        setOpenForm(false);
    };

    const handleChangePage = (event, newPage) => {
        setPage(newPage);
    };

    const handleChangeRowsPerPage = (event) => {
        setRowsPerPage(+event.target.value);
        setPage(0);
    };

    return (
        <Paper sx={{ width: '100%', overflow: 'auto' }}>
            {openForm && <DepartmentForm open={openForm} handleClose={handleCloseForm} action={handleActionForm} setup={setupForm} />}
            <Backdrop open={loading} />
            <Stack direction="row" alignItems="center" justifyContent="space-between" mb={5}>
                <Typography variant="h4">Danh sách phòng ban</Typography>

                <Button onClick={handleOpenForm} variant="contained" color="inherit" startIcon={<Iconify icon="eva:plus-fill" />}>
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
                        {managementUnits?.length > 0 && managementUnits
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
                                            <Button onClick={
                                                () => onClickDetail(row)
                                            } sx={{ marginRight: 2 }} variant="contained" color="inherit" startIcon={<Iconify icon="eva:edit-2-fill" />}>
                                                Chi tiết
                                            </Button>
                                            <Button onClick={() => deleteManagementUnit(row.id)} variant="contained" color="error" startIcon={<Iconify icon="eva:trash-fill" />}>
                                                Xóa
                                            </Button>
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
                count={managementUnits.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onPageChange={handleChangePage}
                onRowsPerPageChange={handleChangeRowsPerPage}
            />
        </Paper>
    );
}
