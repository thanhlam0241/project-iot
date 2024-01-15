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
import MachineForm from './machine-form';

import machineApi from 'src/api/machineApi';
import managementUnitApi from 'src/api/managementUnitApi';

import { useSnackbar } from 'notistack';
import { Backdrop } from 'src/components/backdrop';

const columns = [
    { id: 'code', label: 'Mã máy', minWidth: 100 },
    { id: 'name', label: 'Tên máy', minWidth: 100 },
    { id: 'managementUnitName', label: 'Phòng ban', minWidth: 100 },
    // {
    //     id: 'population',
    //     label: 'Population',
    //     minWidth: 170,
    //     align: 'right',
    //     format: (value) => value.toLocaleString('en-US'),
    // },
    // {
    //     id: 'size',
    //     label: 'Size\u00a0(km\u00b2)',
    //     minWidth: 170,
    //     align: 'right',
    //     format: (value) => value.toLocaleString('en-US'),
    // },
    // {
    //     id: 'density',
    //     label: 'Density',
    //     minWidth: 170,
    //     align: 'right',
    //     format: (value) => value.toFixed(2),
    // },
];

function createData(code, name, managementUnit) {
    return { code, name, managementUnit };
}

export default function StickyHeadTable() {
    const [page, setPage] = React.useState(0);
    const [rowsPerPage, setRowsPerPage] = React.useState(5);
    const [openForm, setOpenForm] = React.useState(false);
    const [setupForm, setSetupForm] = React.useState(
        { type: 'ADD', data: null });

    const [machines, setMachines] = React.useState([]);

    const [managemaentUnits, setManagementUnits] = React.useState([]);

    const [loading, setLoading] = React.useState(false);

    const { enqueueSnackbar } = useSnackbar();

    const resetScreen = () => {
        setSetupForm({
            type: 'ADD',
            data: null
        });

        fetchMachines();
        fetchManagementUnits();
    }

    const fetchMachines = async () => {
        try {
            const response = await machineApi.getAll();
            console.log(response);
            setMachines(response.data.map((machine, index) => {
                return {
                    ...machine,
                    stt: index + 1
                }
            }));
        } catch (error) {
            console.log('Failed to fetch machines: ', error);
        }
    }

    const fetchManagementUnits = async () => {
        try {
            const response = await managementUnitApi.getAll();
            setManagementUnits(response.data);
            console.log(response);
        } catch (error) {
            console.log('Failed to fetch management units: ', error);
        }
    }

    const updateMachine = async (id, machine) => {
        setLoading(true);
        try {
            console.log(machine)
            const response = await machineApi.update(id, machine);
            console.log(response);
            enqueueSnackbar('Cập nhật máy chấm công thành công', { variant: 'success' });
            resetScreen();
        } catch (error) {
            console.log('Failed to update machine: ', error);
        } finally {
            setLoading(false);
        }
    }

    const addMachine = async (machine) => {
        setLoading(true);
        try {
            const response = await machineApi.create(machine);
            console.log(response);
            enqueueSnackbar('Thêm mới máy chấm công thành công', { variant: 'success' });
            resetScreen();
        } catch (error) {
            console.log('Failed to add machine: ', error);
        } finally {
            setLoading(false);
        }
    }

    const deleteMachine = async (id) => {
        setLoading(true);
        try {
            const response = await machineApi.delete(id);
            console.log(response);
            enqueueSnackbar('Xóa máy chấm công thành công', { variant: 'success' });
            resetScreen();
        } catch (error) {
            console.log('Failed to delete machine: ', error);
        } finally {
            setLoading(false);
        }
    }

    const actionForm = (type, data, id = null) => {
        if (type === 'ADD') {
            // call api create
            addMachine(data);
        } else {
            // call api update
            updateMachine(id, data);
        }
        handleCloseForm();
    }

    const handleEdit = (data) => {
        setSetupForm({
            type: 'EDIT',
            data: data
        });
        setOpenForm(true);
    }

    React.useEffect(() => {
        fetchMachines();
        fetchManagementUnits();
    }, []);

    const handleOpenForm = () => {
        setOpenForm(true);
    };

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
            {openForm &&
                <MachineForm
                    setup={setupForm}
                    listUnit={managemaentUnits}
                    open={openForm}
                    handleClose={handleCloseForm}
                    action={actionForm}
                />}
            <Backdrop open={loading} />
            <Stack direction="row" alignItems="center" justifyContent="space-between" mb={5}>
                <Typography variant="h4">Danh sách máy chấm công</Typography>

                <Button onClick={handleOpenForm} variant="contained" color="inherit" startIcon={<Iconify icon="eva:plus-fill" />}>
                    Khai báo máy chấm công mới
                </Button>
            </Stack>
            <TableContainer sx={{ height: 450 }} >
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
                            <TableCell align="right"></TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {machines?.length > 0 && machines
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
                                            <Button onClick={() => handleEdit(row)} sx={{ marginRight: 2 }} variant="contained" color="inherit" startIcon={<Iconify icon="eva:edit-2-fill" />}>
                                                Chi tiết
                                            </Button>
                                            <Button onClick={() => deleteMachine(row.id)} variant="contained" color="error" startIcon={<Iconify icon="eva:trash-fill" />}>
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
                count={machines.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onPageChange={handleChangePage}
                onRowsPerPageChange={handleChangeRowsPerPage}
            />
        </Paper>
    );
}
